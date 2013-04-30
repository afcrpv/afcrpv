#encoding: utf-8
class DossierPresenter < BasePresenter
  presents :dossier
  delegate :doublon, :evenement, :comm_evenement, :gravite, :evolution, :incrimines, :contraception_age, :contraception_ant, :contraceptions, :concomitants_pres, :concomitants, :contraception_ci, :contraception_apres, to: :dossier

  def date_recueil
    date(dossier.date_recueil)
  end

  def date_evenement
    date(dossier.date_evenement)
  end

  def patient_data
    patient = dossier.patient
    result = [
      {field: patient.age.to_s, unit: " ans"},
      {field: patient.poids.to_s, unit: " kg"},
      {field: patient.taille.to_s, unit: " cm"}
    ].map {|field_unit| field_unit[:field] + field_unit[:unit] if field_unit[:field]}.compact.join(", ")
    result << " (IMC #{patient.imc})" if patient.imc
  end

  def age_1ere_contraception
    "(âge 1ère contraception : #{dossier.contraception_age} ans)" if dossier.contraception_age
  end

  def contraception_quoi
    "= #{dossier.contraception_quoi}" if dossier.contraception_apres == "Oui"
  end

  def obesite
    dossier.obesite if dossier.obesite == "Oui"
  end

  def tabac
    if ["oui", "sevré"].include?(dossier.tabac)
      out = dossier.tabac
      out += " (#{dossier.tabac_pa} PA)"
      out
    end
  end

  %w(thrombose cv).each do |prefix|
    %w(perso fam).each do |suffix|
      define_method :"#{prefix}_#{suffix}" do
        if dossier.send(:"#{prefix}_#{suffix}") != "Non"
          if dossier.send(:"#{prefix}_#{suffix}") == "Oui"
            dossier.send(:"#{prefix}_#{suffix}_quoi")
          else
            "NSP"
          end
        end
      end
    end
  end

  %w(hta post_partum diabete hyperglycemie migraine_perso migraine_fam).each do |field|
    define_method field do
      dossier.send(field) if dossier.send(field) != "Non"
    end
  end

  %w(autoimmune cancer dyslipidemie illicites autres_cv).each do |prefix|
    define_method prefix do
      dossier.send(:"#{prefix}_quoi") if dossier.send(prefix) != "Non"
    end
  end

  %w(perso fam).each do |suffix|
    define_method :"hhc_#{suffix}" do
      dossier.send(:"hhc_#{suffix}") if dossier.send(:"hhc_#{suffix}") != "Non"
    end
  end

  def circonstances_survenue
    out = []
    %w(chirurgie immobilisation voyage).each do |suffix|
      out << suffix if dossier.send(:"circonstance_#{suffix}")
    end
    out << dossier.circonstance_autre_quoi if dossier.circonstance_autre && dossier.circonstance_autre_quoi
    out = out.any? ? out.join(", ") : nil
  end

  %w(perso fam).each do |prefix|
    define_method :"anomalie_hemostase_#{prefix}_bilan" do
      if dossier.send(:"anomalie_hemostase_#{prefix}_bilan") == "nsp"
        return "NSP"
      else
        if ["avant", "après"].include?(dossier.send(:"anomalie_hemostase_#{prefix}_bilan"))
          out = "bilan " + dossier.send(:"anomalie_hemostase_#{prefix}_bilan") + " évènement"
          if dossier.send(:"anomalie_hemostase_#{prefix}_anomalie") == "Oui"
            out += " (" + dossier.send(:"anomalie_hemostase_#{prefix}_anomalie_nombre") + " anomalies = "
            out += dossier.send(:"anomalie_hemostase_#{prefix}_anomalie_quoi") + ")"
          else
            out += " (négatif)"
          end
          out
        end
      end
    end
  end

  def commentaire
    simple_format dossier.commentaire
  end


  private

  def date(date_value)
    l date_value
  end
end
