#encoding: utf-8
class IndicationsController < ApplicationController
  before_filter :redirect_unless_authorized, except: [:index]
  before_filter :redirect_unless_connected

  def index
    @indications = Indication.all
  end

  def show
    @indication = Indication.find(params[:id])
  end

  def new
    @indication = Indication.new
  end

  def edit
    @indication = Indication.find(params[:id])
  end

  def create
    @indication = Indication.new(params[:indication])

    if @indication.save
      redirect_to indications_url, notice: 'Indication créée avec succès.'
    else
      render action: "new"
    end
  end

  def update
    @indication = Indication.find(params[:id])

    if @indication.update_attributes(params[:indication])
      redirect_to indications_url, notice: 'Indication mise à jour avec succès.'
    else
      render action: "edit"
    end
  end

  def destroy
    @indication = Indication.find(params[:id])
    @indication.destroy

    redirect_to indications_url, notice: 'Indication détruite avec succès.'
  end
end
