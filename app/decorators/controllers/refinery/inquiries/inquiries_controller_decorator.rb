Refinery::Inquiries::InquiriesController.class_eval do

  def thank_you
    @page = ::Refinery::Page.find_by_link_url("/projets/merci")
  end

  protected

  def find_page
    @page = ::Refinery::Page.find_by_link_url("/projets/soumettre")
  end

end
