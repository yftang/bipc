class UsersController < ApplicationController
  before_filter :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user, notice: "User created."
    else
      render 'new'
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
    @user.destroy
    redirect_to users_path
  end

  private
  def user_params
    params.require(:user).permit(:email, :name,
                                 :password, :password_confirmation)
  end

  def set_user
    @user = User.where(id: params[:id]).first
    if not @user
      flash[:alert] = "User not found!"
      redirect_to root_path
    end
  end
end