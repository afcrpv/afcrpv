# encoding: UTF-8

Refinery::PagesController.class_eval do

  def intranet
    @page = ::Refinery::Page.where(:link_url => '/intranet').first
  end

  protected

end
