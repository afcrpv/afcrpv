class Enquete < HydraAttribute::HydraSet
  attr_accessible :entity_type, :evenement_list, :description
  has_many :dossiers, foreign_key: :hydra_set_id
  has_many :evenement_choices
  has_many :evenements, through: :evenement_choices, dependent: :destroy

  def to_s
    description
  end

  def evenement_list
    evenements.map(&:name).join(", ")
  end

  def evenement_list=(names)
    self.evenements = names.split(",").map do |name|
      Evenement.where(name: name.strip).first_or_create!
    end
  end
end
