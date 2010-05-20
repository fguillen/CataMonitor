class QueriesController < ApplicationController
  before_filter :charge_user
  before_filter :charge_query, :only => [:show, :edit, :update, :destroy, :chart]
  def index
    @queries = @user.queries.all
  end
  
  def show
    @query = @user.queries.find(params[:id])
  end
  
  def new
    @query = @user.queries.new
  end
  
  def create
    @query = @user.queries.new(params[:query])
    if @query.save
      flash[:notice] = "Successfully created query."
      redirect_to [@user, @query]
    else
      flash[:alert] = "Error creating query."
      render :action => 'new'
    end
  end
  
  def edit
    @query = @user.queries.find(params[:id])
  end
  
  def update
    @query = @user.queries.find(params[:id])
    if @query.update_attributes(params[:query])
      flash[:notice] = "Successfully updated query."
      redirect_to [@user, @query]
    else
      flash[:alert] = "Error updating query."
      render :action => 'edit'
    end
  end
  
  def destroy
    @query = @user.queries.find(params[:id])
    @query.destroy
    flash[:notice] = "Successfully destroyed queries."
    redirect_to user_queries_path( @user )
  end
  
  def chart
    
  end
  
  def process_mentions
    @query = @user.queries.find(params[:id])
    mentions = CataMonitor::QueriesProcessor.process_query( @query )
    flash[:notice] = "Query procesada, encontradas #{mentions.size} nuevas menciones."
    redirect_to user_query_mentions_by_type_path( @user, @query, 'blogs' )
  end
  
  private
    def charge_query
      @query = Query.find(params[:id])
    end
end
