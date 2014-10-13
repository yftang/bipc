class HomepagesController < ApplicationController
  def welcome
    @title = 'Home'
    if user_signed_in? && current_user.role?(:admin)
      @projects = Project.all
    elsif user_signed_in?
      @user_projects = current_user.projects
      @ongoing_projects = @user_projects.reject(&:complete?)
    end
  end
end
