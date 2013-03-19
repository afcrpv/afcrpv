class MedicamentChoice < ActiveRecord::Base
  belongs_to :medicament
  belongs_to :enquete
  # attr_accessible :title, :body
end
