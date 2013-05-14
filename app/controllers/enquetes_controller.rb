#encoding: utf-8
require "iconv"
class EnquetesController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_filter :find_dossier_for_edit, only: [:show]
  before_filter :redirect_unless_authorized, except: [:show, :index]
  before_filter :redirect_unless_connected

  %w(evenement medicament).each do |method|
    define_method :"add_#{method}s" do
      association_names = params[:"#{method}_names"].join(", ")
      enquete = Enquete.find(params[:enquete_id])
      enquete.send :"#{method}_list=", association_names
      redirect_to polymorphic_path(method.classify.constantize),
        notice: "#{method.titleize.pluralize} #{association_names} rajoutés à l'enquête #{enquete.name}"
    end
  end

  def index
    @enquetes = Enquete.all
  end

  def show
    @enquete = Enquete.find(params[:id])
    dossiers = @enquete.dossiers.includes(:patient, :evenement, :incrimines => :medicament)
    if authorised_enquetes_user?
      dossiers = dossiers.where{refinery_crpv_id == my{params[:search]}} if params[:search].present?
    else
      dossiers = dossiers.where{refinery_crpv_id == my{current_refinery_user.refinery_crpv_id}}
    end

    @dossiers = dossiers.order(sort_column + " " + sort_direction)

    respond_to do |format|
      format.html
      format.js
      format.csv { send_data Iconv.conv('iso-8859-1//IGNORE', 'utf-8', @dossiers.to_csv(col_sep: ";")),
                   filename: "#{@enquete.name}_dossiers.csv" }
      format.xls
      format.pdf do
        pdf = EnquetePdf.new(@enquete, view_context, @dossiers)
        send_data pdf.render, filename: "#{@enquete.name}_dossiers.pdf",
                              type: "application/pdf",
                              disposition: "inline"
      end
    end
  end

  def new
    @enquete = Enquete.new
  end

  def create
    @enquete = Enquete.new(params[:enquete])
    if @enquete.save
      redirect_to enquetes_path, notice: "Enquête créée avec succès"
    else
      render :new
    end
  end

  def edit
    @enquete = Enquete.find(params[:id])
  end

  def update
    @enquete = Enquete.find(params[:id])
    if @enquete.update_attributes(params[:enquete])
      redirect_to enquetes_path, notice: "Enquête : #{@enquete.name} mise à jour avec succès."
    else
      render :edit
    end
  end

  def destroy
    @enquete = Enquete.find(params[:id])
    @enquete.destroy
    redirect_to enquetes_path, notice: "Enquête : #{@enquete.name} détruite avec succès."
  end

  private

  def find_dossier_for_edit
    if params[:code_bnpv].present?
      @search = Dossier.where(code_bnpv: params[:code_bnpv]).first rescue nil
      if @search
        redirect_to edit_dossier_path(@search)
      else
        redirect_to enquetes_path, notice: "Aucun dossier avec le N° BNPV: #{params[:code_bnpv]}"
      end
    end
  end


  def sort_column
    Dossier.column_names.include?(params[:sort]) ? params[:sort] : "date_recueil"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
