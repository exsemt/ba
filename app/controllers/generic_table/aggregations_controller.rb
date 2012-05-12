class GenericTable::AggregationsController < ApplicationController
  # GET /generic_table/aggregations
  # GET /generic_table/aggregations.json
  def index
    @generic_table_aggregations = GenericTable::Aggregation.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @generic_table_aggregations }
    end
  end

  # GET /generic_table/aggregations/1
  # GET /generic_table/aggregations/1.json
  def show
    @generic_table_aggregation = GenericTable::Aggregation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @generic_table_aggregation }
    end
  end

  # GET /generic_table/aggregations/new
  # GET /generic_table/aggregations/new.json
  def new
    @generic_table_aggregation = GenericTable::Aggregation.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @generic_table_aggregation }
    end
  end

  # GET /generic_table/aggregations/1/edit
  def edit
    @generic_table_aggregation = GenericTable::Aggregation.find(params[:id])
  end

  # POST /generic_table/aggregations
  # POST /generic_table/aggregations.json
  def create
    @generic_table_aggregation = GenericTable::Aggregation.new(params[:generic_table_aggregation])

    respond_to do |format|
      if @generic_table_aggregation.save
        format.html { redirect_to @generic_table_aggregation, notice: 'Aggregation was successfully created.' }
        format.json { render json: @generic_table_aggregation, status: :created, location: @generic_table_aggregation }
      else
        format.html { render action: "new" }
        format.json { render json: @generic_table_aggregation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /generic_table/aggregations/1
  # PUT /generic_table/aggregations/1.json
  def update
    @generic_table_aggregation = GenericTable::Aggregation.find(params[:id])

    respond_to do |format|
      if @generic_table_aggregation.update_attributes(params[:generic_table_aggregation])
        format.html { redirect_to @generic_table_aggregation, notice: 'Aggregation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @generic_table_aggregation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /generic_table/aggregations/1
  # DELETE /generic_table/aggregations/1.json
  def destroy
    @generic_table_aggregation = GenericTable::Aggregation.find(params[:id])
    @generic_table_aggregation.destroy

    respond_to do |format|
      format.html { redirect_to generic_table_aggregations_url }
      format.json { head :no_content }
    end
  end
end
