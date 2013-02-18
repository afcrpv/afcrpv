class TagsController < ApplicationController
  def index
    @tags = ActsAsTaggableOn::Tag.named_like(params[:q])
    respond_to do |format|
      format.json do
        tag_list = @tags.any? ? @tags.map(&:name_and_id) : [{id: params[:q], text: params[:q]}]
        render json: tag_list
      end
    end
  end
end
