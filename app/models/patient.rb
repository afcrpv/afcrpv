class Patient < ActiveRecord::Base
  attr_accessible :age, :imc, :poids, :taille, :dossier_id
  belongs_to :dossier
end
