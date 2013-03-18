#encoding: utf-8
class TypeEnquetesController < ApplicationController
  before_filter :redirect_unless_connected_and_authorized, except: [:show, :index]
  helper_method :authorised_enquetes_user?

  def index
    @type_enquetes = TypeEnquete.all
  end

  def show
    @type_enquete = TypeEnquete.find(params[:id])
    @dossiers = @type_enquete.dossiers.all
  end

  def new
    @type_enquete = TypeEnquete.new(entity_type: "Dossier")
  end

  def create
    @type_enquete = TypeEnquete.new(params[:type_enquete])
    if @type_enquete.save
      redirect_to type_enquetes_path, notice: "Type d'enquête créée avec succès"
    else
      render :new
    end
  end

  def edit
    @type_enquete = TypeEnquete.find(params[:id])
  end

  def update
    @type_enquete = TypeEnquete.find(params[:id])
    if @type_enquete.update_attributes(params[:type_enquete])
      redirect_to type_enquetes_path, notice: "Type Enquête : #{@type_enquete.name} mis à jour avec succès."
    else
      render :edit
    end
  end

  def destroy
    @type_enquete = TypeEnquete.find(params[:id])
    @type_enquete.destroy
    redirect_to type_enquetes_path, notice: "Type Enquête : #{@type_enquete.name} détruit avec succès."
  end

  protected

  def redirect_unless_connected_and_authorized
    redirect_to "/intranet", notice: "Vous n'êtes pas autorisé à voir cette page !" unless authorised_enquetes_user?
  end

  def authorised_enquetes_user?
    current_refinery_user && (current_refinery_user.has_role?('enquetes') or current_refinery_user.is_admin?)
  end
end
