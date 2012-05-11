class Star::BranchesController < ApplicationController
  # GET /star/branches
  # GET /star/branches.json
  def index
    @star_branches = Star::Branch.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @star_branches }
    end
  end

  # GET /star/branches/1
  # GET /star/branches/1.json
  def show
    @star_branch = Star::Branch.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @star_branch }
    end
  end

  # GET /star/branches/new
  # GET /star/branches/new.json
  def new
    @star_branch = Star::Branch.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @star_branch }
    end
  end

  # GET /star/branches/1/edit
  def edit
    @star_branch = Star::Branch.find(params[:id])
  end

  # POST /star/branches
  # POST /star/branches.json
  def create
    @star_branch = Star::Branch.new(params[:star_branch])

    respond_to do |format|
      if @star_branch.save
        format.html { redirect_to @star_branch, notice: 'Branch was successfully created.' }
        format.json { render json: @star_branch, status: :created, location: @star_branch }
      else
        format.html { render action: "new" }
        format.json { render json: @star_branch.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /star/branches/1
  # PUT /star/branches/1.json
  def update
    @star_branch = Star::Branch.find(params[:id])

    respond_to do |format|
      if @star_branch.update_attributes(params[:star_branch])
        format.html { redirect_to @star_branch, notice: 'Branch was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @star_branch.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /star/branches/1
  # DELETE /star/branches/1.json
  def destroy
    @star_branch = Star::Branch.find(params[:id])
    @star_branch.destroy

    respond_to do |format|
      format.html { redirect_to star_branches_url }
      format.json { head :no_content }
    end
  end
end
