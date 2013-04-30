#encoding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :crpv_name
  helper_method :authorised_dossiers_user?
  helper_method :authorised_enquetes_user?

  private

  def present(object, klass = nil)
    DossierPresenter.new(object, view_context)
  end

  def redirect_unless_authorized
    redirect_to "/intranet", notice: "Vous n'êtes pas autorisé à voir cette page !" unless authorised_enquetes_user?
  end

  def redirect_unless_connected
    redirect_to "/members/login?member_login=true&redirect=#{request.fullpath}", notice: "Veuillez vous connecter pour accéder à cette page." unless current_refinery_user
  end

  def authorised_enquetes_user?
    current_refinery_user && (current_refinery_user.has_role?('enquetes') or current_refinery_user.is_admin?)
  end

  def crpv_name
    @crpv_name ||= @crpv.name if @crpv
  end
end
