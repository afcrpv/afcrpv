# encoding: UTF-8

require 'simple-rss'

Refinery::PagesController.class_eval do
  before_filter :find_pv_news, only: [:home]
  before_filter :find_agences, only: [:home]

  protected

  def find_agences
    @agences = [
      {name: "HAS", description: "dernières synthèses d'avis"},
      {name: "ANSM", description: "dernières informations de sécurité"},
      {name: "FDA", description: "medwatch safety alerts"}
]
  end

  def find_pv_news
    @pv_news = []
  end
end
