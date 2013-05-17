class Incrimine < Traitement
  attr_accessible :medicament_id, :indication_id, :indication_autre_quoi

  belongs_to :indication
  belongs_to :medicament

  delegate :classe, to: :medicament

  def full_indication
    if indication_autre_quoi.present?
      indication_autre_quoi
    else
      indication.to_s
    end
  end
end
