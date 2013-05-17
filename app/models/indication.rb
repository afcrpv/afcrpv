class Indication < ActiveRecord::Base
  attr_accessible :name
  has_many :traitements

  def to_s
    name
  end
end
