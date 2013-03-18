#encoding: utf-8
class TypeEnquetesController < ApplicationController
  def index
    @type_enquetes = TypeEnquete.all
  end

  def new
    @type_enquete = Enquete.hydra_sets.new
  end

  def create
    @type_enquete = Enquete.hydra_sets.new(params[:hydra_attribute_hydra_set])
    if @type_enquete.save
      redirect_to type_enquetes_path, notice: "Type d'enquête créée avec succès"
    else
      render :new
    end
  end
end
