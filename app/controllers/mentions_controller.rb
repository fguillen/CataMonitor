class MentionsController < ApplicationController
  before_filter :charge_user
  before_filter :charge_query
  
  def by_type
    @mentions = @query.mentions.by_type(params[:type]).between_dates( Time.now - params[:num_days].to_i.days, Time.now )
    render :action => 'index'
  end
  
  def index
    @mentions = @query.mentions.all
  end
  
  def chart
    
  end
  
  private
    def charge_user
      @user = User.find(params[:user_id])
    end
    
    def charge_query
      @query = @user.queries.find(params[:query_id])
    end
end
