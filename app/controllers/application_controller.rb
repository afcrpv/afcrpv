class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :crpv_name

  private

  def crpv_name
    @crpv_name ||= @crpv.name if @crpv
  end
end
