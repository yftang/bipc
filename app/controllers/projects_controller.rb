class ProjectsController < ApplicationController
  before_filter :set_project, only: [:edit, :show,
                                     :update, :destroy]
  authorize_resource

  def search_projects
    search_acc = params[:search_project_acc].strip
    search_result = Project.where("acc LIKE ?", search_acc)
    if search_result
      projects = []
      search_result.each do |p|
        projects << {
          id:         p.id,
          acc:        p.acc,
          start_date: p.start_date
        }
      end
      render :json => projects.to_json
    else
      render :json => nil
    end
  end

  def index
    @projects = Project.all.page params[:page]
    @project = Project.new
  end

  def new
    @project = Project.new
  end

  def edit
  end

  def show
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      return render :json => { :success => true }
    else
      return render :json => { :success => false }
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
    @project.destroy
  end

  private
  def project_params
    params.require(:project).permit(:acc, :start_date, :deadline)
  end

  def set_project
    @project = Project.where(id: params[:id]).first
    if not @project
      flash[:alert] = "Project not found!"
      redirect_to projects_path
    end
  end
end
