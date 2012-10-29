module Refinery
  module Emplois
    class Emploi < Refinery::Core::BaseModel
      extend FriendlyId

      include Humanizer
      attr_accessor :bypass_humanizer
      attr_accessible :humanizer_answer, :humanizer_question_id

      if Rails.env.production?
        require_human_on :create, :unless => :bypass_humanizer
      end

      friendly_id :id_and_title, use: :slugged
      self.table_name = 'refinery_emplois'

      attr_accessible :organisation, :name, :email, :telephone, :address, :title, :description, :expires_on, :attachment, :attachment_id, :position

      acts_as_indexed :fields => [:organisation, :name, :email, :telephone, :address, :title, :description]

      [:organisation, :name, :email, :telephone, :address, :title, :description, :expires_on].each do |field|
        validates field, :presence => true
      end

      belongs_to :attachment, :class_name => '::Refinery::Resource'

      def id_and_title
        "#{id} #{title}"
      end
    end
  end
end
