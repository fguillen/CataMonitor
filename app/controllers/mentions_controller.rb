class MentionsController < ApplicationController
  before_filter :charge_user
  before_filter :charge_query
  
  def by_type
    @mentions = @query.mentions.by_type(params[:type])
    render :action => 'index'
  end
  
  def index
    @mentions = @query.mentions.all
  end
  
  private
    def charge_user
      @user = User.find(params[:user_id])
    end
    
    def charge_query
      @query = @user.queries.find(params[:query_id])
    end
end
