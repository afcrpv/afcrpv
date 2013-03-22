class EnqueteField < ActiveRecord::Base
  attr_accessible :field_type, :name, :libelle, :required, :position
  belongs_to :enquete
  acts_as_list scope: :enquete
end
