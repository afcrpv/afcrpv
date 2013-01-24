class DepartementsController < ApplicationController
  def index
    @departements = Departement.with_cp_or_name(params[:q])
    respond_to do |format|
      format.json {render json: @departements.map(&:cp_name_and_cp)}
    end
  end
end
