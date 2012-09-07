require 'simple-rss'
require 'open-uri'

module Refinery
  module Agences
    class Agence < Refinery::Core::BaseModel
      self.table_name = 'refinery_agences'

      attr_accessible :name, :description, :feed_url, :position

      acts_as_indexed :fields => [:name, :description, :feed_url]

      validates :name, :presence => true, :uniqueness => true

      def feeds
        get_rss_entries(feed_url)
      end

      private

      def get_rss_entries(url, limit=5)
        SimpleRSS.parse(open(url)).entries[1..limit]
      end
    end
  end
end
