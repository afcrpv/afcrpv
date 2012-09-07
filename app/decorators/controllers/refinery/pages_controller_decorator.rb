# encoding: UTF-8

Refinery::PagesController.class_eval do
  before_filter :find_pv_news, only: [:home]
  before_filter :find_agences, only: [:home]

  protected

  def find_agences
    @agences ||= Refinery::Agences::Agence.all
  end

  def find_pv_news
    @pv_news = []
  end
end
