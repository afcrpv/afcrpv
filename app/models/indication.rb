class Indication < ActiveRecord::Base
  attr_accessible :name
  has_many :traitements
end
