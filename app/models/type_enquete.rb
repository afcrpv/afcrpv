class TypeEnquete < HydraAttribute::HydraSet
  attr_accessible :evenement_list, :entity_type

  acts_as_ordered_taggable
  acts_as_ordered_taggable_on :evenements
end
