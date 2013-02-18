class TagsController < ApplicationController
  def index
    @tags = ActsAsTaggableOn::Tag.named_like(params[:q])
    respond_to do |format|
      format.json {render json: @tags.map(&:name_and_id)}
    end
  end
end
