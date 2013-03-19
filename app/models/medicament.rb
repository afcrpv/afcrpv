class Medicament < ActiveRecord::Base
  attr_accessible :name, :classe, :forme, :type
  has_many :traitements, dependent: :destroy
  has_many :dossiers, through: :traitements
end
