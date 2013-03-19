class Medicament < ActiveRecord::Base
  attr_accessible :name, :classe, :forme
  has_many :traitements, dependent: :destroy
  has_many :dossiers, through: :traitements

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      Medicament.create! row.to_hash
    end
  end
end
