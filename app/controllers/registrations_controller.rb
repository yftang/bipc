class RegistrationsController < Devise::RegistrationsController
  def create
    if not params[:user][:role_id].blank?
      user = User.new user_params.except('role_id')
      if user.save
        role = Role.where(:id => params[:user][:role_id]).first
        role.users << user
        flash[:notice] = 'User created!'
        return render :json => { :success => true }
      else
        flash[:danger] = 'User not created!'
        return render :json => { :success => false }
      end
    else
      flash[:danger] = 'User not created!'
      return render :json => { :success => false }
    end
  end

  private
  def user_params
    @user_params ||= params.require(:user).permit(:email, :name, :role_id)
  end
end
