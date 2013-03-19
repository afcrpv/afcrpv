class EvenementChoice < ActiveRecord::Base
  belongs_to :enquete
  belongs_to :evenement
end
