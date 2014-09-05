class RegistrationsController < Devise::RegistrationsController
  def create
    if not params[:user][:role_ids].blank?
      user = User.create user_params.except('role_ids')
      params[:user][:role_ids].each do |id|
        role = Role.where(id: id).first
        role.users << user
      end
      return render :json => { :success => true }
    else
      user = User.new user_params.except('role_ids')
      return render :json => { :success => false } if not user.save
      return render :json => { :success => true }
    end
  end

  private
  def user_params
    @user_params ||= params.require(:user).permit(:email, :name, :role_ids)
  end
end
