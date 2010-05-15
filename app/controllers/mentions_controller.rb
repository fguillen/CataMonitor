class MentionsController < ApplicationController
  def index
    @mentions = Mention.all
  end
  
  def show
    @mention = Mention.find(params[:id])
  end
  
  def new
    @mention = Mention.new
  end
  
  def create
    @mention = Mention.new(params[:mention])
    if @mention.save
      flash[:notice] = "Successfully created mention."
      redirect_to @mention
    else
      render :action => 'new'
    end
  end
  
  def edit
    @mention = Mention.find(params[:id])
  end
  
  def update
    @mention = Mention.find(params[:id])
    if @mention.update_attributes(params[:mention])
      flash[:notice] = "Successfully updated mention."
      redirect_to @mention
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @mention = Mention.find(params[:id])
    @mention.destroy
    flash[:notice] = "Successfully destroyed mention."
    redirect_to mentions_url
  end
end
