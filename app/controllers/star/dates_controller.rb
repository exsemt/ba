class Star::DatesController < ApplicationController
  # GET /star/dates
  # GET /star/dates.json
  def index
    @star_dates = Star::Date.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @star_dates }
    end
  end

  # GET /star/dates/1
  # GET /star/dates/1.json
  def show
    @star_date = Star::Date.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @star_date }
    end
  end

  # GET /star/dates/new
  # GET /star/dates/new.json
  def new
    @star_date = Star::Date.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @star_date }
    end
  end

  # GET /star/dates/1/edit
  def edit
    @star_date = Star::Date.find(params[:id])
  end

  # POST /star/dates
  # POST /star/dates.json
  def create
    @star_date = Star::Date.new(params[:star_date])

    respond_to do |format|
      if @star_date.save
        format.html { redirect_to @star_date, notice: 'Date was successfully created.' }
        format.json { render json: @star_date, status: :created, location: @star_date }
      else
        format.html { render action: "new" }
        format.json { render json: @star_date.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /star/dates/1
  # PUT /star/dates/1.json
  def update
    @star_date = Star::Date.find(params[:id])

    respond_to do |format|
      if @star_date.update_attributes(params[:star_date])
        format.html { redirect_to @star_date, notice: 'Date was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @star_date.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /star/dates/1
  # DELETE /star/dates/1.json
  def destroy
    @star_date = Star::Date.find(params[:id])
    @star_date.destroy

    respond_to do |format|
      format.html { redirect_to star_dates_url }
      format.json { head :no_content }
    end
  end
end
