class SamplesController < ApplicationController
  before_filter :set_sample, :only => [:update, :destroy, :edit, :show,
                                       :add_project, :delete_project]

  authorize_resource

  def index
    @title = 'Samples management'
    @samples = Sample.all.page params[:page]
  end

  def new
    @title = 'Create new sample'
    @sample = Sample.new
    @project_accs = Project.all.pluck(:acc)
  end

  def show
    @title = @sample.name
  end

  def edit
    @title = "Edit #{@sample.name}"
    @project_accs = Project.all.pluck(:acc)
  end

  def add_project
    if @sample && params[:project_acc] && \
        project=Project.find_by_acc(params[:project_acc])
      existing_accs = @sample.projects.pluck(:acc)
      if existing_accs.include?(params[:project_acc])
        return render :json => { :success => false,
                                 :info    => 'Already included!' }
      else
        ProjectSample.create(:project_id => project.id,
                             :sample_id  => @sample.id)
        return render :json => { :success => true,
                                 :info    => 'Wonderful!' }
      end
    else
      return render :json => {
          :success => false,
          :info    => 'Sample or Project not found, try to reload page!' }
    end
  end

  def delete_project
    if @sample && params[:project_acc] && \
        project=Project.find_by_acc(params[:project_acc])
      existing_projects = @sample.projects
      if !existing_projects.include?(project)
        return render :json => {
            :success => false,
            :info    => 'Project not included, try to reload the page!' }
      else
        sample_projects = @sample.project_samples
        ProjectSample.where(
          :project_id => project.id,
          :sample_id  => @sample.id
        ).first.destroy
        return render :json => { :success => true,
                                 :info    => 'Wonderful!' }
      end
    else
      return render :json => {
          :success => false,
          :info    => 'Sample or Project not found, try to reload page!' }
    end
  end

  def update
    if @sample.update_attributes(sample_params)
      flash[:notice] = "Sample updated!"
      redirect_to @sample
    else
      flash[:notice] = "Sample not updated!"
      render 'edit'
    end
  end

  def create
    @sample = Sample.new(sample_params.merge(:receiver => current_user.name,
                                             :receiver_id => current_user.id))
    if @sample.save
      flash[:notice] = "Connect project now!"
      redirect_to edit_sample_path(@sample)
    else
      flash[:notice] = "Sample not created!"
      render 'new'
    end
  end

  def destroy
    if @sample.destroy
      return render :json => { :success => true }
    else
      return render :json => { :success => false }
    end
  end

  private
  def sample_params
    params.require(:sample).permit(:name, :received_date, :express_number)
  end

  def set_sample
    @sample = Sample.where(id: params[:id]).first
    if !@sample
      flash[:alert] = "Sample not found!"
      redirect_to root_path
    end
  end
end
