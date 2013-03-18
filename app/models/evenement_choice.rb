class EvenementChoice < ActiveRecord::Base
  belongs_to :type_enquete
  belongs_to :evenement
  # attr_accessible :title, :body
end
