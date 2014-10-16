class UsersController < ApplicationController
  before_filter :set_user, only: [:show, :edit, :update, :destroy]

  load_and_authorize_resource

  def index
    @title = 'User management'
    if current_user.role? :admin
      @users = User.all.page params[:page]
    elsif current_user.role? :salesman_admin
      @users = Kaminari::paginate_array(
        User.all.select { |u| u.role?(:salesman) }
      ).page params[:page]
    elsif current_user.role? :marketing_admin
      @users = Kaminari::paginate_array(
        User.all.select { |u| u.role?(:marketing) }
      ).page params[:page]
    elsif current_user.role? :experimenter_admin
      @users = Kaminari::paginate_array(
        User.all.select { |u| u.role?(:experimenter) }
      ).page params[:page]
    elsif current_user.role? :bioinformatician_admin
      @users = Kaminari::paginate_array(
        User.all.select { |u| u.role?(:bioinformatician) }
      ).page params[:page]
    end
    @user = User.new
  end

  def show
    @title = @user.name
    @user_projects = @user.projects
    @ongoing_projects = @user_projects.reject(&:complete?)
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
    params.require(:user).permit(:email, :name, :phone)
  end

  def set_user
    @user = User.where(id: params[:id]).first
    if not @user
      flash[:alert] = "User not found!"
      redirect_to root_path
    end
  end
end
