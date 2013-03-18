#encoding: utf-8
class TypeEnquetesController < ApplicationController
  def tags
    @tags = ActsAsTaggableOn::Tag.joins(:taggings).where("taggings.context = ?", params[:context]).named_like(params[:q])
    respond_to do |format|
      format.json do
        tag_list = @tags.any? ? @tags.map(&:name_and_id) : [{id: params[:q], text: params[:q]}]
        render json: tag_list
      end
    end
  end

  def index
    @type_enquetes = TypeEnquete.all
  end

  def new
    @type_enquete = TypeEnquete.new(entity_type: "Enquete")
  end

  def create
    @type_enquete = TypeEnquete.new(params[:type_enquete])
    if @type_enquete.save
      redirect_to type_enquetes_path, notice: "Type d'enquête créée avec succès"
    else
      render :new
    end
  end
end
