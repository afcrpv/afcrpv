#encoding: utf-8
class DossiersController < ApplicationController
  before_filter :redirect_unless_connected
  before_filter :find_dossier_for_edit
  helper_method :evenements
  helper_method :medicaments
  helper_method :indications
  helper_method :enquete

  def index
    respond_to do |format|
      format.json { render json: DossiersDatatable.new(view_context) }
      format.xlsx do
        @dossiers = DossiersDatatable.new(view_context).as_records
        response.headers['Content-Disposition'] = "attachment; filename='#{Date.current}_dossiers.xlsx'"
      end
    end
  end

  def show
    @dossier = Dossier.find(params[:id])
    respond_to do |format|
      format.html {render layout: false}
      format.pdf do
        dossier = dossier_present(@dossier)
        pdf = DossierPdf.new(dossier, view_context)
        send_data pdf.render, filename: "dossier_#{dossier.code_bnpv}.pdf",
                              type: "application/pdf",
                              disposition: "inline"
      end
    end
  end

  def new
    @dossier = Dossier.new(enquete_id: params[:enquete_id], refinery_crpv_id: current_refinery_user.refinery_crpv_id)
    @dossier.build_patient
    @dossier.incrimines.build
    @dossier.contraceptions.build
    @dossier.concomitants.build
  end

  def create
    @dossier = Dossier.new(params[:dossier])
    if @dossier.save
      redirect_on_success("Le dossier #{@dossier.code_bnpv} a été créé avec succès.")
    else
      render :new
    end
  end

  def edit
    @dossier = Dossier.find(params[:id])
    @dossier.build_patient unless @dossier.patient
    @dossier.incrimines.build unless @dossier.incrimines.any?
    @dossier.contraceptions.build unless @dossier.contraceptions.any?
    @dossier.concomitants.build unless @dossier.concomitants.any?
    redirect_to enquete_path(id: @dossier.enquete_id), notice: "Vous ne pouvez pas modifier ce dossier." unless user_crpv_owns_dossier? or authorised_enquetes_user? or current_refinery_user.is_admin?
  end

  def update
    @dossier = Dossier.find(params[:id])
    if @dossier.update_attributes(params[:dossier])
      redirect_on_success("Le dossier #{@dossier.code_bnpv} a été mis à jour avec succès.")
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

  def dossier_present(object, klass = nil)
    DossierPresenter.new(object, view_context)
  end

  def enquete
    @enquete ||= params[:id] ? @dossier.enquete : (params[:dossier] ? Enquete.find(params[:dossier][:enquete_id]) : Enquete.find(params[:enquete_id]) )
  end

  def indications
    @indications = Indication.all
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

  def find_dossier_for_edit
    if params[:code_bnpv]
      @search = Dossier.where(code_bnpv: params[:code_bnpv]).first rescue nil
      if @search
        redirect_to edit_dossier_path(@search)
      else
        redirect_to enquetes_path, notice: "Aucun dossier avec le N° BNPV: #{params[:code_bnpv]}"
      end
    end
  end

  def redirect_on_success(flash_message)
    if params[:_continue]
      redirect_to edit_dossier_path(@dossier), notice: flash_message
    else
      redirect_to enquete_path(id: @dossier.enquete_id), notice: flash_message
    end
  end
end
