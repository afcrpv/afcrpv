#encoding: utf-8
class MedicamentsController < ApplicationController
  before_filter :redirect_unless_authorized, except: [:index]
  before_filter :redirect_unless_connected

  def import
    Medicament.import(params[:file])
    redirect_to medicaments_path, notice: "Médicaments importés avec succès."
  end

  def liste
    @medicaments = Medicament.named_like(params[:q])

    respond_to do |format|
      format.json do
        render json: @medicaments.map(&:name_and_id)
      end
    end
  end

  # GET /medicaments
  # GET /medicaments.json
  def index
    respond_to do |format|
      format.html
      format.json { render json: MedicamentsDatatable.new(view_context) }
    end
  end

  # GET /medicaments/1
  # GET /medicaments/1.json
  def show
    @medicament = Medicament.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @medicament }
    end
  end

  # GET /medicaments/new
  # GET /medicaments/new.json
  def new
    @medicament = Medicament.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @medicament }
    end
  end

  # GET /medicaments/1/edit
  def edit
    @medicament = Medicament.find(params[:id])
  end

  # POST /medicaments
  # POST /medicaments.json
  def create
    @medicament = Medicament.new(params[:medicament])

    respond_to do |format|
      if @medicament.save
        format.html { redirect_to medicaments_path, notice: "Médicament '#{@medicament.name}' créé avec succès." }
        format.json { render json: @medicament, status: :created, location: @medicament }
      else
        format.html { render action: "new" }
        format.json { render json: @medicament.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /medicaments/1
  # PUT /medicaments/1.json
  def update
    @medicament = Medicament.find(params[:id])

    respond_to do |format|
      if @medicament.update_attributes(params[:medicament])
        format.html { redirect_to medicaments_path, notice: "Médicament '#{@medicament.name}' mis à jour." }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @medicament.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /medicaments/1
  # DELETE /medicaments/1.json
  def destroy
    @medicament = Medicament.find(params[:id])
    @medicament.destroy

    respond_to do |format|
      format.html { redirect_to medicaments_url, notice: "Médicament '#{@medicament.name}' détruit." }
      format.json { head :no_content }
    end
  end
end
