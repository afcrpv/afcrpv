class Patient < ActiveRecord::Base
  belongs_to :refinery_enquete
  attr_accessible :age, :imc, :poids, :taille, :refinery_enquete_id
end
