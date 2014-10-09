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
    @exp_role = Role.find_by_name('Experimenter')
    @bin_role = Role.find_by_name('Bioinformatician')
    @mkt_role = Role.find_by_name('Marketing')
  end

  def new
    @project   = Project.new
    @customers = Customer.all
    @samples   = Sample.all
  end

  def edit
  end

  def show
  end

  def create
    @project = Project.new(
      { :creater    => current_user.name,
        :creater_id => current_user.id }.merge(project_params)
    )
    if params[:project][:customer_ids] && @project.save
      customer_ids = params[:project][:customer_ids]
      customer_ids.each do |id|
        ProjectCustomer.create(:project_id  => @project.id,
                               :customer_id => id)
      end
      flash[:notice] = 'Project created'
      redirect_to @project
    else
      flash[:notice] = 'Project not created'
      @customers = Customer.all
      render 'new'
    end
  end

  def set_salesman
    set_participant('salesman', params)
  end

  def set_experimenter
    set_participant('experimenter', params)
  end

  def set_bioinformatician
    set_participant('bioinformatician', params)
  end

  def set_marketing
    set_participant('marketing', params)
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

  def set_participant(role, params)
    if params[:id] && params[:user_name] && params[:user_id]
      user_name, user_id = params[:user_name], params[:user_id]
      if tmp_project = Project.where(:id => params[:id]).first
        tmp_project.update_attributes(role.to_sym         => user_name,
                                      "#{role}_id".to_sym => user_id)
        UserProject.create(:user_id    => user_id,
                           :project_id => params[:id],
                           :role_name  => role.camelize)
        return render :json => { :success => true }
      else
        return render :json => { :success => false }
      end
    else
      return render :json => { :success => false }
    end
  end
end
