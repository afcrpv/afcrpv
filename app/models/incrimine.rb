class Incrimine < Traitement
  attr_accessible :medicament_id, :indication_id, :indication_autre_quoi

  belongs_to :indication
  belongs_to :medicament

  def full_indication
    if indication_autre_quoi
      indication_autre_quoi
    else
      indication
    end
  end
end
