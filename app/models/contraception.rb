class Contraception < Traitement
  attr_accessible :medicament_id
  belongs_to :medicament
end
