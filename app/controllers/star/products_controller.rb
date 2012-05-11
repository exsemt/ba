class Star::ProductsController < ApplicationController
  # GET /star/products
  # GET /star/products.json
  def index
    @star_products = Star::Product.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @star_products }
    end
  end

  # GET /star/products/1
  # GET /star/products/1.json
  def show
    @star_product = Star::Product.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @star_product }
    end
  end

  # GET /star/products/new
  # GET /star/products/new.json
  def new
    @star_product = Star::Product.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @star_product }
    end
  end

  # GET /star/products/1/edit
  def edit
    @star_product = Star::Product.find(params[:id])
  end

  # POST /star/products
  # POST /star/products.json
  def create
    @star_product = Star::Product.new(params[:star_product])

    respond_to do |format|
      if @star_product.save
        format.html { redirect_to @star_product, notice: 'Product was successfully created.' }
        format.json { render json: @star_product, status: :created, location: @star_product }
      else
        format.html { render action: "new" }
        format.json { render json: @star_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /star/products/1
  # PUT /star/products/1.json
  def update
    @star_product = Star::Product.find(params[:id])

    respond_to do |format|
      if @star_product.update_attributes(params[:star_product])
        format.html { redirect_to @star_product, notice: 'Product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @star_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /star/products/1
  # DELETE /star/products/1.json
  def destroy
    @star_product = Star::Product.find(params[:id])
    @star_product.destroy

    respond_to do |format|
      format.html { redirect_to star_products_url }
      format.json { head :no_content }
    end
  end
end
