#encoding: utf-8
class EnquetesController < ApplicationController
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
end
