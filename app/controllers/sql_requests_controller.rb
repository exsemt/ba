class SqlRequestsController < ApplicationController
  # GET /sql_requests
  # GET /sql_requests.json
  def index
    @sql_requests = SqlRequest.order('id DESC').limit(100)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sql_requests }
    end
  end

  # GET /sql_requests/1
  # GET /sql_requests/1.json
  def show
    @sql_request = SqlRequest.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sql_request }
    end
  end

  # DELETE /sql_requests/1
  # DELETE /sql_requests/1.json
  def destroy
    if params[:id] == 'all'
      SqlRequest.delete_all
      ActiveRecord::Base.connection.execute("ALTER TABLE %s AUTO_INCREMENT = %d" % [SqlRequest.table_name, 1])
    else
      @sql_request = SqlRequest.find(params[:id])
      @sql_request.destroy
    end

    respond_to do |format|
      format.html { redirect_to sql_requests_url }
      format.json { head :no_content }
    end
  end
end
