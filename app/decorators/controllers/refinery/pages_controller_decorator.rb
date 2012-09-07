# encoding: UTF-8

require 'simple-rss'
require 'open-uri'

Refinery::PagesController.class_eval do
  before_filter :find_pv_news, only: [:home]
  before_filter :find_agences, only: [:home]

  protected

  def find_agences
    @agences ||= [
      {name: "HAS", description: "dernières synthèses d'avis", news: get_rss_entries('http://www.has-sante.fr/portail/feed/Rss2.jsp?id=c_754989')},
      {name: "ANSM", description: "dernières informations de sécurité", news: get_rss_entries('http://ansm.sante.fr/syndication/rss')},
      {name: "FDA", description: "medwatch safety alerts", news: get_rss_entries('http://www.fda.gov/AboutFDA/ContactFDA/StayInformed/RSSFeeds/MedWatch/rss.xml')}
]
  end

  def find_pv_news
    @pv_news = []
  end

  def get_rss_entries(url, limit=5)
    SimpleRSS.parse(open(url)).entries[1..limit]
  end
end
