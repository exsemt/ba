class GenericTable::FactValuesController < ApplicationController
  # GET /generic_table/fact_values
  # GET /generic_table/fact_values.json
  def index
    @generic_table_fact_values = GenericTable::FactValue.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @generic_table_fact_values }
    end
  end

  # GET /generic_table/fact_values/1
  # GET /generic_table/fact_values/1.json
  def show
    @generic_table_fact_value = GenericTable::FactValue.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @generic_table_fact_value }
    end
  end

  # GET /generic_table/fact_values/new
  # GET /generic_table/fact_values/new.json
  def new
    @generic_table_fact_value = GenericTable::FactValue.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @generic_table_fact_value }
    end
  end

  # GET /generic_table/fact_values/1/edit
  def edit
    @generic_table_fact_value = GenericTable::FactValue.find(params[:id])
  end

  # POST /generic_table/fact_values
  # POST /generic_table/fact_values.json
  def create
    @generic_table_fact_value = GenericTable::FactValue.new(params[:generic_table_fact_value])

    respond_to do |format|
      if @generic_table_fact_value.save
        format.html { redirect_to @generic_table_fact_value, notice: 'Fact value was successfully created.' }
        format.json { render json: @generic_table_fact_value, status: :created, location: @generic_table_fact_value }
      else
        format.html { render action: "new" }
        format.json { render json: @generic_table_fact_value.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /generic_table/fact_values/1
  # PUT /generic_table/fact_values/1.json
  def update
    @generic_table_fact_value = GenericTable::FactValue.find(params[:id])

    respond_to do |format|
      if @generic_table_fact_value.update_attributes(params[:generic_table_fact_value])
        format.html { redirect_to @generic_table_fact_value, notice: 'Fact value was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @generic_table_fact_value.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /generic_table/fact_values/1
  # DELETE /generic_table/fact_values/1.json
  def destroy
    @generic_table_fact_value = GenericTable::FactValue.find(params[:id])
    @generic_table_fact_value.destroy

    respond_to do |format|
      format.html { redirect_to generic_table_fact_values_url }
      format.json { head :no_content }
    end
  end
end
