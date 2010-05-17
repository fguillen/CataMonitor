class UsersController < ApplicationController
  before_filter :require_user, :only => [:show, :edit, :update]
  
  def index
    @users = User.all
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Account registered!"
      redirect_to @user
    else
      flash[:alert] = "Error on user creation"
      render :action => :new
    end
  end
  
  def show
    @user = User.find( params[:id] )
  end

  def edit
    @user = User.find( params[:id] )
  end
  
  def update
    @user = User.find( params[:id] )
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to @user
    else
      flash[:alert] = "Error on user updating."
      render :action => :edit
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "Successfully destroyed User."
    redirect_to users_path
  end
end
