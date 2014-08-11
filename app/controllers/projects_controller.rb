class ProjectsController < ApplicationController
  before_filter :set_project, only: [:new, :edit, :show,
                                     :create, :update, :destroy]

  def index
    @projects = Project.all
  end

  def new
  end

  def edit
  end

  def show
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      flash[:success] = 'New project created!'
      redirect_to @project
    else
      render 'new'
    end
  end

  def update
    if @project.update_attributes(project_params)
      flash[:success] = "Project updated"
      redirect_to @project
    else
      render 'edit'
    end
  end

  def destroy
  end

  private
  def project_params
    params.require(:project).permit(:acc, :start_date, :end_date)
  end

  def set_project
    @project = Project.where(id: params[:id]).first || Project.new
  end
end
