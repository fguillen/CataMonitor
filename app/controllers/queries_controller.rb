class QueriesController < ApplicationController
  before_filter :charge_user
  before_filter :charge_query, :only => [:show, :new, :edit, :update, :destroy, :chart]
  def index
    @queries = @user.queries.all
  end
  
  def show
    @queries = Queries.find(params[:id])
  end
  
  def new
    @queries = Queries.new
  end
  
  def create
    @queries = Queries.new(params[:queries])
    if @queries.save
      flash[:notice] = "Successfully created queries."
      redirect_to @queries
    else
      render :action => 'new'
    end
  end
  
  def edit
    @queries = Queries.find(params[:id])
  end
  
  def update
    @queries = Queries.find(params[:id])
    if @queries.update_attributes(params[:queries])
      flash[:notice] = "Successfully updated queries."
      redirect_to @queries
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @queries = Queries.find(params[:id])
    @queries.destroy
    flash[:notice] = "Successfully destroyed queries."
    redirect_to queries_url
  end
  
  def chart
    
  end
  
  private
    def charge_query
      @query = Query.find(params[:id])
      
    end
end
