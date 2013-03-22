class Enquete < ActiveRecord::Base
  attr_accessible :name, :evenement_list, :medicament_list, :description, :fields_attributes
  #has_many :dossiers
  #has_many :evenement_choices
  #has_many :evenements, through: :evenement_choices, dependent: :destroy, order: "LOWER(name)"
  #has_many :medicament_choices
  #has_many :medicaments, through: :medicament_choices, dependent: :destroy, order: "LOWER(name)"

  has_many :fields, class_name: "EnqueteField", order: :position
  accepts_nested_attributes_for :fields, allow_destroy: true

  def to_s
    description
  end

  #%w[evenement medicament].each do |method|
    #define_method :"#{method}_list" do
      #self.send(:"#{method}s").map(&:name).join(", ")
    #end

    #define_method :"#{method}_list=" do |names|
      #self.send(:"#{method}s=",
                #names.split(",").map {|name| method.classify.constantize.where(name: name.strip).first_or_create!})
    #end
  #end
end
