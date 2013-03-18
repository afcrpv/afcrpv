class EvenementsController < ApplicationController
  # GET /evenements
  # GET /evenements.json
  def index
    @evenements = Evenement.named_like(params[:q])

    respond_to do |format|
      format.html # index.html.erb
      format.json do
        render json: @evenements.map(&:name_and_id)
      end
    end
  end

  # GET /evenements/1
  # GET /evenements/1.json
  def show
    @evenement = Evenement.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @evenement }
    end
  end

  # GET /evenements/new
  # GET /evenements/new.json
  def new
    @evenement = Evenement.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @evenement }
    end
  end

  # GET /evenements/1/edit
  def edit
    @evenement = Evenement.find(params[:id])
  end

  # POST /evenements
  # POST /evenements.json
  def create
    @evenement = Evenement.new(params[:evenement])

    respond_to do |format|
      if @evenement.save
        format.html { redirect_to @evenement, notice: 'Evenement was successfully created.' }
        format.json { render json: @evenement, status: :created, location: @evenement }
      else
        format.html { render action: "new" }
        format.json { render json: @evenement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /evenements/1
  # PUT /evenements/1.json
  def update
    @evenement = Evenement.find(params[:id])

    respond_to do |format|
      if @evenement.update_attributes(params[:evenement])
        format.html { redirect_to @evenement, notice: 'Evenement was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @evenement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /evenements/1
  # DELETE /evenements/1.json
  def destroy
    @evenement = Evenement.find(params[:id])
    @evenement.destroy

    respond_to do |format|
      format.html { redirect_to evenements_url }
      format.json { head :no_content }
    end
  end
end
