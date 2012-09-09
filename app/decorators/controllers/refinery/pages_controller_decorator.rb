# encoding: UTF-8

Refinery::PagesController.class_eval do
  before_filter :find_pv_news, only: [:home]
  before_filter :find_agences, only: [:home]

  protected

  def find_agences
    selected_agences = []
    %w(ANSM HAS FDA).each do |name|
      selected_agences << Refinery::Agences::Agence.find_by_name(name)
    end
    @agences ||= selected_agences
  end

  def find_pv_news
    @pv_news = []
  end
end
