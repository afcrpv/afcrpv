module Refinery
  module Enquetes
    class Enquete < Refinery::Core::BaseModel
      self.table_name = 'refinery_enquetes'

      attr_accessible :code_bnpv, :date_recueil, :doublon, :j_evenement, :m_evenement, :a_evenement, :comm_evenement, :gravite, :evolution, :j_evolution, :m_evolution, :a_evolution, :commentaire, :position

      acts_as_indexed :fields => [:code_bnpv, :comm_evenement, :gravite, :evolution, :commentaire]

      validates :code_bnpv, :presence => true, :uniqueness => true
    end
  end
end
