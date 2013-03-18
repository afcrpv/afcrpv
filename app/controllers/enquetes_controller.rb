#encoding: utf-8
class EnquetesController < ApplicationController
  before_filter :find_all_enquetes, only: [:index]
  before_filter :redirect_or_render

  helper_method :authorised_documents_user?

  def index
  end

  def show
    @enquete = Enquete.find(params[:id])
  end

  def new
    @enquete = Enquete.new(hydra_set_id: params[:hydra_set_id])
    @enquete.build_patient
  end

  def edit
    @enquete = Enquete.find(params[:id])
  end

  def create
    @enquete = Enquete.new(params[:enquete])
    if @enquete.save
      redirect_to enquetes_path, succes: "L'enquête a été créée avec succès."
    else
      render :new
    end
  end

  protected

  def find_all_enquetes
    @enquetes = Enquete.order('position ASC')
  end

  def redirect_or_render
    redirect_to "/members/login?member_login=true&redirect=#{request.fullpath}" unless current_refinery_user
  end
end
