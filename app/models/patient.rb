class Patient < ActiveRecord::Base
  belongs_to :dossier
  attr_accessible :age, :imc, :poids, :taille, :dossier_id
end
