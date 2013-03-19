class Medicament < ActiveRecord::Base
  attr_accessible :name, :classe, :forme
  has_many :traitements, dependent: :destroy
  has_many :dossiers, through: :traitements
  has_many :medicament_choices, dependent: :destroy
  has_many :enquetes, through: :medicament_choices

  def name_and_id
    {id: name, text: name}
  end

  def to_s
    name
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      Medicament.create! row.to_hash
    end
  end
end
