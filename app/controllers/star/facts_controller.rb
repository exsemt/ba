class Star::FactsController < ApplicationController
  # GET /star/facts
  # GET /star/facts.json
  def index
    @star_facts = Star::Fact.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @star_facts }
    end
  end

  # GET /star/facts/1
  # GET /star/facts/1.json
  def show
    @star_fact = Star::Fact.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @star_fact }
    end
  end

  # GET /star/facts/new
  # GET /star/facts/new.json
  def new
    @star_fact = Star::Fact.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @star_fact }
    end
  end

  # GET /star/facts/1/edit
  def edit
    @star_fact = Star::Fact.find(params[:id])
  end

  # POST /star/facts
  # POST /star/facts.json
  def create
    @star_fact = Star::Fact.new(params[:star_fact])

    respond_to do |format|
      if @star_fact.save
        format.html { redirect_to @star_fact, notice: 'Fact was successfully created.' }
        format.json { render json: @star_fact, status: :created, location: @star_fact }
      else
        format.html { render action: "new" }
        format.json { render json: @star_fact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /star/facts/1
  # PUT /star/facts/1.json
  def update
    @star_fact = Star::Fact.find(params[:id])

    respond_to do |format|
      if @star_fact.update_attributes(params[:star_fact])
        format.html { redirect_to @star_fact, notice: 'Fact was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @star_fact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /star/facts/1
  # DELETE /star/facts/1.json
  def destroy
    @star_fact = Star::Fact.find(params[:id])
    @star_fact.destroy

    respond_to do |format|
      format.html { redirect_to star_facts_url }
      format.json { head :no_content }
    end
  end
end
