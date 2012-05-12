class GenericTable::DimensionsController < ApplicationController
  # GET /generic_table/dimensions
  # GET /generic_table/dimensions.json
  def index
    @generic_table_dimensions = GenericTable::Dimension.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @generic_table_dimensions }
    end
  end

  # GET /generic_table/dimensions/1
  # GET /generic_table/dimensions/1.json
  def show
    @generic_table_dimension = GenericTable::Dimension.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @generic_table_dimension }
    end
  end

  # GET /generic_table/dimensions/new
  # GET /generic_table/dimensions/new.json
  def new
    @generic_table_dimension = GenericTable::Dimension.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @generic_table_dimension }
    end
  end

  # GET /generic_table/dimensions/1/edit
  def edit
    @generic_table_dimension = GenericTable::Dimension.find(params[:id])
  end

  # POST /generic_table/dimensions
  # POST /generic_table/dimensions.json
  def create
    @generic_table_dimension = GenericTable::Dimension.new(params[:generic_table_dimension])

    respond_to do |format|
      if @generic_table_dimension.save
        format.html { redirect_to @generic_table_dimension, notice: 'Dimension was successfully created.' }
        format.json { render json: @generic_table_dimension, status: :created, location: @generic_table_dimension }
      else
        format.html { render action: "new" }
        format.json { render json: @generic_table_dimension.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /generic_table/dimensions/1
  # PUT /generic_table/dimensions/1.json
  def update
    @generic_table_dimension = GenericTable::Dimension.find(params[:id])

    respond_to do |format|
      if @generic_table_dimension.update_attributes(params[:generic_table_dimension])
        format.html { redirect_to @generic_table_dimension, notice: 'Dimension was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @generic_table_dimension.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /generic_table/dimensions/1
  # DELETE /generic_table/dimensions/1.json
  def destroy
    @generic_table_dimension = GenericTable::Dimension.find(params[:id])
    @generic_table_dimension.destroy

    respond_to do |format|
      format.html { redirect_to generic_table_dimensions_url }
      format.json { head :no_content }
    end
  end
end
