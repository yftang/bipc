class UsersController < ApplicationController
  before_filter :set_user, only: [:show, :edit, :update, :destroy]

  load_and_authorize_resource

  def index
    @users = User.all.page params[:page]
    @user = User.new
  end

  def show
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "User created!"
      return render :json => { :success => true }
    else
      return render :json => { :success => false }
    end
  end

  def update
    if @user.update_attributes(user_params)
      redirect_to @user, notice: "User profile updated!"
    else
      render 'edit'
    end
  end

  def destroy
    if @user.destroy
      return render :json => { :success => true }
    else
      return render :json => { :success => false }
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :name)
  end

  def set_user
    @user = User.where(id: params[:id]).first
    if not @user
      flash[:alert] = "User not found!"
      redirect_to root_path
    end
  end
end
