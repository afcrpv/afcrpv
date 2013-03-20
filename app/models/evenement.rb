class Evenement < ActiveRecord::Base
  attr_accessible :name
  has_many :dossiers
  has_many :evenement_choices, dependent: :destroy
  has_many :enquetes, through: :evenement_choices

  validates_presence_of :name

  def name_and_id
    {id: name, text: name}
  end

  def to_s
    name
  end

  def self.named_like(query)
    where("LOWER(name) like ?", "%#{query}%")
  end
end
