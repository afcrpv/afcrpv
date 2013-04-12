class Traitement < ActiveRecord::Base
  attr_accessible :duree, :duree_unite, :duree_comp

  belongs_to :dossier

  def duree_ttt
    [duree_comp, duree, duree_unite].compact.join(" ")
  end
end
