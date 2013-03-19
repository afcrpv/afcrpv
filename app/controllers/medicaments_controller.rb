#encoding: utf-8
class MedicamentsController < ApplicationController
  before_filter :redirect_unless_authorized, except: [:index]
  before_filter :redirect_unless_connected
  helper_method :authorised_enquetes_user?

  def import
    Medicament.import(params[:file])
    redirect_to medicaments_path, notice: "Médicaments importés avec succès."
  end

  # GET /medicaments
  # GET /medicaments.json
  def index
    @medicaments = Medicament.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @medicaments }
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
        format.html { redirect_to @medicament, notice: 'Medicament was successfully created.' }
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
        format.html { redirect_to @medicament, notice: 'Medicament was successfully updated.' }
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
      format.html { redirect_to medicaments_url }
      format.json { head :no_content }
    end
  end

  protected

  def redirect_unless_authorized
    redirect_to "/intranet", notice: "Vous n'êtes pas autorisé à voir cette page !" unless authorised_enquetes_user?
  end

  def redirect_unless_connected
    redirect_to "/members/login?member_login=true&redirect=#{request.fullpath}", notice: "Veuillez vous connecter pour accéder à cette page." unless current_refinery_user
  end

  def authorised_enquetes_user?
    current_refinery_user && (current_refinery_user.has_role?('enquetes') or current_refinery_user.is_admin?)
  end
end
