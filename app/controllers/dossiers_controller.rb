#encoding: utf-8
class DossiersController < ApplicationController
  before_filter :redirect_unless_connected
  helper_method :evenements
  helper_method :medicaments
  helper_method :enquete

  def index
    respond_to do |format|
      format.html
      format.json { render json: DossiersDatatable.new(view_context) }
      format.xlsx do
        @dossiers = DossiersDatatable.new(view_context).as_xlsx
        response.headers['Content-Disposition'] = "attachment; filename='#{Date.current}_dossiers.xlsx'"
      end
    end
  end

  def show
    @dossier = Dossier.find(params[:id])
  end

  def new
    @dossier = Dossier.new(enquete_id: params[:enquete_id], refinery_crpv_id: current_refinery_user.refinery_crpv_id)
    @dossier.build_patient
  end

  def create
    @dossier = Dossier.new(params[:dossier])
    if @dossier.save
      redirect_to enquete_path(params[:dossier][:enquete_id]), succes: "Le dossier a été créé avec succès."
    else
      render :new
    end
  end

  def edit
    @dossier = Dossier.find(params[:id])
    @dossier.build_patient unless @dossier.patient
    redirect_to enquete_path(id: @dossier.enquete_id), notice: "Vous ne pouvez pas modifier ce dossier." unless user_crpv_owns_dossier? or current_refinery_user.is_admin?
  end

  def update
    @dossier = Dossier.find(params[:id])
    if @dossier.update_attributes(params[:dossier])
      redirect_to enquete_path(id: @dossier.enquete_id), notice: "Dossier : #{@dossier.code_bnpv} mis à jour avec succès."
    else
      render :edit
    end
  end

  def destroy
    @dossier = Dossier.find(params[:id])
    @dossier.destroy
    redirect_to enquete_path(id: @dossier.enquete_id), notice: "Dossier : #{@dossier.code_bnpv} détruit avec succès."
  end

  protected

  def enquete
    @enquete ||= params[:id] ? @dossier.enquete : Enquete.find(params[:enquete_id])
  end

  def evenements
    @evenements = Evenement.all
  end

  def medicaments
    @medicaments = Medicament.order("LOWER(name)")
  end

  def user_crpv_owns_dossier?
    if current_refinery_user.respond_to?(:refinery_crpv)
      @dossier.crpv == current_refinery_user.refinery_crpv
    else
      return false
    end
  end
end
