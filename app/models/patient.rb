class Patient < ActiveRecord::Base
  attr_accessible :age, :imc, :poids, :taille, :dossier_id
  belongs_to :dossier

  def data
    result = [
      {field: age.to_s, unit: " ans"},
      {field: poids.to_s, unit: " kg"},
      {field: taille.to_s, unit: " cm"}
    ].map {|field_unit| field_unit[:field] + field_unit[:unit] if field_unit[:field]}.compact.join(", ")
    result << " (IMC #{imc})" if imc
  end
end
