#encoding: utf-8
class DossiersController < ApplicationController
  before_filter :redirect_unless_connected
  helper_method :evenements
  helper_method :authorised_dossiers_user?

  def show
    @dossier = Dossier.find(params[:id])
  end

  def new
    @dossier = Dossier.new(hydra_set_id: params[:hydra_set_id], refinery_crpv_id: current_refinery_user.refinery_crpv_id)
    @dossier.build_patient
  end

  def create
    @dossier = Dossier.new(params[:dossier])
    if @dossier.save
      redirect_to dossiers_path, succes: "L'enquête a été créée avec succès."
    else
      render :new
    end
  end

  def edit
    @dossier = Dossier.find(params[:id])
    redirect_to dossiers_path, notice: "Vous ne pouvez pas modifier cette enquête." unless user_crpv_owns_dossier? or current_refinery_user.is_admin?
  end

  def update
    @dossier = Dossier.find(params[:id])
    if @dossier.update_attributes(params[:dossier])
      redirect_to dossiers_path, notice: "Enquête : #{@dossier.code_bnpv} mise à jour avec succès."
    else
      render :edit
    end
  end

  def destroy
    @dossier = Dossier.find(params[:id])
    @dossier.destroy
    redirect_to dossiers_path, notice: "Enquête : #{@dossier.code_bnpv} détruite avec succès."
  end

  protected

  def redirect_unless_connected
    redirect_to "/members/login?member_login=true&redirect=#{request.fullpath}", notice: "Veuillez vous connecter pour accéder à cette page." unless current_refinery_user
  end

  def evenements
    type_enquete ||= params[:id] ? @dossier.type_enquete : TypeEnquete.find(params[:hydra_set_id])
    @evenements = type_enquete ? type_enquete.evenements.all : Evenement.all
  end

  def authorised_dossiers_user?
    current_refinery_user && (current_refinery_user.has_role?('enquetes') or current_refinery_user.is_admin?)
  end

  def user_crpv_owns_dossier?
    if current_refinery_user.respond_to?(:refinery_crpv)
      @dossier.crpv == current_refinery_user.refinery_crpv
    else
      return false
    end
  end
end
