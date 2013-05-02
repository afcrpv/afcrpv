#encoding: utf-8
class DossierPresenter < BasePresenter
  presents :dossier
  delegate :code_bnpv, :doublon, :evenement, :comm_evenement, :gravite, :evolution, :incrimines, :contraception_age, :contraception_ant, :contraceptions, :concomitants_pres, :concomitants, :contraception_ci, :contraception_apres, to: :dossier

  def date_recueil
    date(dossier.date_recueil)
  end

  def date_evenement
    date(dossier.date_evenement)
  end

  def age
    value_with_unit dossier.age, "ans"
  end

  def poids
    value_with_unit dossier.poids, "kg"
  end

  def taille
    value_with_unit dossier.taille, "cm"
  end

  def imc
    dossier.imc if dossier.imc
  end

  def poids_taille_imc
    result = [poids, taille].join(" x ")
    result << " (IMC #{imc})" if imc
  end

  def patient_data
    [age, poids_taille_imc].compact.join(", ")
  end

  def age_1ere_contraception
    "(âge 1ère contraception : #{dossier.contraception_age} ans)" if dossier.contraception_age
  end

  def contraception_quoi
    "= #{dossier.contraception_quoi}" if dossier.contraception_apres == "Oui"
  end

  def fdr_communs
    [obesite, tabac, thrombose, cv, hta, autoimmune, cancer, hhc].compact.join(", ")
  end

  def fdr_veineux
    [circonstances_survenue, post_partum, hemostase].compact.join(", ")
  end

  def fdr_arterieux
    [migraine, diabete, hyperglycemie, dyslipidemie, illicites, autres_cv].compact.join(", ")
  end

  def obesite
    Dossier.human_attribute_name(:obesite) if dossier.obesite == "Oui"
  end

  def tabac
    if ["oui", "sevré"].include?(dossier.tabac)
      out = Dossier.human_attribute_name(:tabac)
      out += t("activerecord.attributes.dossier.tabac_pa", pa: dossier.tabac_pa)
      out
    end
  end

  def thrombose
    out = [thrombose_perso, thrombose_fam].compact
    out.join(", ") if out.any?
  end

  def cv
    out = [cv_perso, cv_fam].compact
    out.join(", ") if out.any?
  end

  def hhc
    out = [hhc_perso, hhc_fam].compact
    out.join(", ") if out.any?
  end

  %w(thrombose cv).each do |prefix|
    %w(perso fam).each do |suffix|
      define_method :"#{prefix}_#{suffix}" do
        if dossier.send(:"#{prefix}_#{suffix}") == "Oui"
          dossier.send(:"#{prefix}_#{suffix}_quoi")
        end
      end
    end
  end

  def migraine
    out = [migraine_perso, migraine_fam].compact
    out.join(", ") if out.any?
  end

  %w(hta post_partum diabete hyperglycemie migraine_perso migraine_fam).each do |field|
    define_method field do
      Dossier.human_attribute_name(field) if dossier.send(field) == "Oui"
    end
  end

  %w(autoimmune cancer dyslipidemie illicites autres_cv).each do |prefix|
    define_method prefix do
      dossier.send(:"#{prefix}_quoi") if dossier.send(prefix) == "Oui"
    end
  end

  %w(perso fam).each do |suffix|
    define_method :"hhc_#{suffix}" do
      Dossier.human_attribute_name(:"hhc_#{suffix}") if dossier.send(:"hhc_#{suffix}") == "Oui"
    end
  end

  def circonstances_survenue
    out = []
    %w(chirurgie immobilisation voyage).each do |suffix|
      out << suffix if dossier.send(:"circonstance_#{suffix}")
    end
    out << dossier.circonstance_autre_quoi if dossier.circonstance_autre && dossier.circonstance_autre_quoi
    out.join(", ") if out.any?
  end

  def hemostase
    out = [hemostase_perso, hemostase_fam].compact
    out.join(", ") if out.any?
  end

  %w(perso fam).each do |prefix|
    define_method :"hemostase_#{prefix}" do
      if ["avant", "après"].include?(dossier.send(:"anomalie_hemostase_#{prefix}_bilan"))
        if dossier.send(:"anomalie_hemostase_#{prefix}_anomalie") == "Oui"
          out = []
          out << pluralize(dossier.send(:"anomalie_hemostase_#{prefix}_anomalie_nombre").to_i, "anomalie")
          out << "de l'hemostase"
          out << "(#{dossier.send(:"anomalie_hemostase_#{prefix}_anomalie_quoi")})"
          out.join(" ") if out.any?
        end
      end
    end
  end

  def commentaire
    simple_format dossier.commentaire
  end


  private

  def value_with_unit(value, unit)
    if value.present?
      "#{value} #{unit}"
    end
  end


  def date(date_value)
    l date_value
  end
end
