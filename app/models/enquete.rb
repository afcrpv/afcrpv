class Enquete < HydraAttribute::HydraSet
  attr_accessible :entity_type, :evenement_list, :description
  has_many :dossiers, foreign_key: :hydra_set_id
  has_many :evenement_choices
  has_many :evenements, through: :evenement_choices, dependent: :destroy
  has_many :medicament_choices
  has_many :medicaments, through: :medicament_choices, dependent: :destroy

  def to_s
    description
  end

  %w[evenement medicament].each do |method|
    define_method :"#{method}_list" do
      self.send(:"#{method}s").map(&:name).join(", ")
    end

    define_method :"#{method}_list=" do |names|
      self.send(:"#{method}s=",
                names.split(",").map {|name| method.classify.constantize.where(name: name.strip).first_or_create!})
    end
  end
end
