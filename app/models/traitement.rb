class Traitement < ActiveRecord::Base
  attr_accessible :medicament_id, :indication_id, :indication_autre_quoi, :duree, :duree_unite, :duree_comp

  belongs_to :dossier
  belongs_to :indication
  belongs_to :medicament

  def duree_ttt
    [duree_comp, duree, duree_unite].compact.join(" ")
  end
end
