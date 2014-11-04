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
    @title = 'Projects management'
    @projects = Project.all.page params[:page]
    @project = Project.new
    @exp_role = Role.find_by_name('Experimenter')
    @bin_role = Role.find_by_name('Bioinformatician')
    @mkt_role = Role.find_by_name('Marketing')
  end

  def new
    @title = 'Create new project'
    @project   = Project.new
    @customers = Customer.all
    @samples   = Sample.all
    @salesmen  = Role.find_by_name('Salesman').users
  end

  def edit
    @title = "Edit #{@project.acc}"
    @customers = Customer.all
    @salesmen  = Role.find_by_name('Salesman').users
  end

  def show
    @title = @project.acc
  end

  def create
    customer_ids = params[:project][:customer_ids]
    salesman_id = params[:project][:salesman_id]
    @project = Project.new(
      { :creater     => current_user.name,
        :creater_id  => current_user.id,
        :salesman    => User.find_by_id(salesman_id).name
      }.merge(project_params)
    )
    if customer_ids && salesman_id && @project.save
      UserProject.create(:user_id    => salesman_id,
                         :project_id => @project.id)
      customer_ids.each do |id|
        ProjectCustomer.create(:project_id  => @project.id,
                               :customer_id => id)
      end
      flash[:notice] = 'Project created'
      redirect_to @project
    else
      flash[:danger] = 'Project not created'
      @customers = Customer.all
      @salesmen  = Role.find_by_name('Salesman').users
      render 'new'
    end
  end

  def set_complete
    if current_user.role_one_of?(
        [:marketing, :marketing_admin])
      if self.analysis_done?
        set_complete_date('report')
      else
        set_complete_date('sample')
      end
    elsif current_user.role_one_of?(
        [:experimenter, :experimenter_admin])
      set_complete_date('experiment')
    elsif current_user.role_one_of?(
        [:bioinformatician, :bioinformatician_admin])
      set_complete_date('analysis')
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

  def set_samples_receiver
    set_participant('samples_receiver', params)
  end

  def set_report_sender
    set_participant('report_sender', params)
  end

  def update
    if @project.update_attributes(project_params)
      flash[:notice] = "Project updated"
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
    params.require(:project).permit(:acc, :salesman_id, :start_date, :deadline)
  end

  def set_project
    @project = Project.where(id: params[:id]).first
    if not @project
      flash[:alert] = "Project not found!"
      redirect_to projects_path
    end
  end

  def set_participant(operator, params)
    if params[:id] && params[:user_name] && params[:user_id]
      user_name, user_id = params[:user_name], params[:user_id]
      if tmp_project = Project.where(:id => params[:id]).first
        role = ['samples_receiver', 'report_sender'].include?(operator) ? \
            'marketing' : operator
        tmp_project.update_attributes(role.to_sym         => user_name,
                                      "#{role}_id".to_sym => user_id)
        UserProject.create(:user_id    => user_id,
                           :project_id => params[:id],
                           :role_name  => role.camelize)
        tmp_user = User.find_by_id(user_id)
        return render :json => {  :success => true,
                                  :param   => tmp_user.to_param }
      else
        return render :json => { :success => false }
      end
    else
      return render :json => { :success => false }
    end
  end

  def set_complete_date(procedure)
    complete_date = Time.now.to_date
    if procedure.is_a?(String) && complete_date && params[:id]
      project = Project.find_by_id params[:id]
      if !project
        flash[:notice] = 'Project not found!'
        redirect_to root_path
      end

      case procedure
      when 'sample'
        if project.update_attribute(:samples_received_date, complete_date)
          flash[:notice] = 'Well done!'
        end
      when 'experiment'
        if project.update_attribute(:experiments_done_date, complete_date)
          flash[:notice] = 'Well done!'
        end
      when 'analysis'
        if project.update_attribute(:analysis_done_date, complete_date)
          flash[:notice] = 'Well done!'
        end
      when 'report'
        if project.update_attribute(:report_sent_date, complete_date)
          flash[:notice] = 'Well done!'
        end
      else
        flash[:notice] ='Something wrong happened, try again!'
      end
      redirect_to root_path
    else
      flash[:notice] ='Something wrong happened, try again!'
      redirect_to root_path
    end
  end
end
