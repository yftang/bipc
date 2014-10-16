class HomepagesController < ApplicationController
  def welcome
    @title = 'Home'
    if user_signed_in? && !current_user.role?(:admin)
      @project_accs = Project.all.pluck(:acc)
      @user_projects = current_user.projects
      @ongoing_projects = @user_projects.reject(&:complete?)
    end
  end

  def goto_project
    if params
      temp_acc = params[:project_acc]
      if temp_project = Project.find_by_acc(temp_acc)
        redirect_to project_path(temp_project)
      else
        flash[:notice] = 'Project not found!'
        redirect_to root_path
      end
    end
  end
end
