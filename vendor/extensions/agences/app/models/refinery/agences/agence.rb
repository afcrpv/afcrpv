require 'simple-rss'
require 'open-uri'
require 'friendly_id'

module Refinery
  module Agences
    class Agence < Refinery::Core::BaseModel
      extend FriendlyId

      default_scope order("name")

      friendly_id :name, use: :slugged

      self.table_name = 'refinery_agences'

      attr_accessible :name, :description, :feed_url, :position, :slug

      acts_as_indexed :fields => [:name, :description, :feed_url]

      validates :name, :presence => true, :uniqueness => true

      def feeds(limit=5)
        get_rss_entries(feed_url, limit) rescue nil
      end

      private

      def get_rss_entries(url, limit)
        SimpleRSS.parse(open(url)).entries[1..limit]
      end
    end
  end
end
