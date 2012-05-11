class Star::CustomersController < ApplicationController
  # GET /star/customers
  # GET /star/customers.json
  def index
    @star_customers = Star::Customer.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @star_customers }
    end
  end

  # GET /star/customers/1
  # GET /star/customers/1.json
  def show
    @star_customer = Star::Customer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @star_customer }
    end
  end

  # GET /star/customers/new
  # GET /star/customers/new.json
  def new
    @star_customer = Star::Customer.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @star_customer }
    end
  end

  # GET /star/customers/1/edit
  def edit
    @star_customer = Star::Customer.find(params[:id])
  end

  # POST /star/customers
  # POST /star/customers.json
  def create
    @star_customer = Star::Customer.new(params[:star_customer])

    respond_to do |format|
      if @star_customer.save
        format.html { redirect_to @star_customer, notice: 'Customer was successfully created.' }
        format.json { render json: @star_customer, status: :created, location: @star_customer }
      else
        format.html { render action: "new" }
        format.json { render json: @star_customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /star/customers/1
  # PUT /star/customers/1.json
  def update
    @star_customer = Star::Customer.find(params[:id])

    respond_to do |format|
      if @star_customer.update_attributes(params[:star_customer])
        format.html { redirect_to @star_customer, notice: 'Customer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @star_customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /star/customers/1
  # DELETE /star/customers/1.json
  def destroy
    @star_customer = Star::Customer.find(params[:id])
    @star_customer.destroy

    respond_to do |format|
      format.html { redirect_to star_customers_url }
      format.json { head :no_content }
    end
  end
end
