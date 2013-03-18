#encoding: utf-8
class EnquetesController < ApplicationController
  before_filter :redirect_unless_connected
  helper_method :evenements
  helper_method :authorised_enquetes_user?

  def show
    @enquete = Enquete.find(params[:id])
  end

  def new
    @enquete = Enquete.new(hydra_set_id: params[:hydra_set_id], refinery_crpv_id: current_refinery_user.refinery_crpv_id)
    @enquete.build_patient
  end

  def create
    @enquete = Enquete.new(params[:enquete])
    if @enquete.save
      redirect_to enquetes_path, succes: "L'enquête a été créée avec succès."
    else
      render :new
    end
  end

  def edit
    @enquete = Enquete.find(params[:id])
    redirect_to enquetes_path, notice: "Vous ne pouvez pas modifier cette enquête." unless user_crpv_owns_enquete? or current_refinery_user.is_admin?
  end

  def update
    @enquete = Enquete.find(params[:id])
    if @enquete.update_attributes(params[:enquete])
      redirect_to enquetes_path, notice: "Enquête : #{@enquete.code_bnpv} mise à jour avec succès."
    else
      render :edit
    end
  end

  def destroy
    @enquete = Enquete.find(params[:id])
    @enquete.destroy
    redirect_to enquetes_path, notice: "Enquête : #{@enquete.code_bnpv} détruite avec succès."
  end

  protected

  def redirect_unless_connected
    redirect_to "/members/login?member_login=true&redirect=#{request.fullpath}", notice: "Veuillez vous connecter pour accéder à cette page." unless current_refinery_user
  end

  def evenements
    type_enquete ||= params[:id] ? @enquete.type_enquete : TypeEnquete.find(params[:hydra_set_id])
    @evenements = type_enquete ? type_enquete.evenements.all : Evenement.all
  end

  def authorised_enquetes_user?
    current_refinery_user && (current_refinery_user.has_role?('enquetes') or current_refinery_user.is_admin?)
  end

  def user_crpv_owns_enquete?
    if current_refinery_user.respond_to?(:refinery_crpv)
      @enquete.crpv == current_refinery_user.refinery_crpv
    else
      return false
    end
  end
end
