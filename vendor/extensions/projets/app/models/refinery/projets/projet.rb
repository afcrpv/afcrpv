module Refinery
  module Projets
    class Projet < Refinery::Core::BaseModel
      validates :name, :presence => true
      validates :message, :presence => true
      validates :email, :format=> { :with =>  /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }

      acts_as_indexed :fields => [:name, :email, :message, :phone]

      default_scope :order => 'created_at DESC'

      attr_accessible :name, :phone, :message, :email

      def self.latest(number = 7)
        limit(number)
      end

      include Humanizer
      attr_accessor :bypass_humanizer
      attr_accessible :humanizer_answer, :humanizer_question_id

      if Rails.env.production?
        require_human_on :create, :unless => :bypass_humanizer
      end
    end
  end
end
