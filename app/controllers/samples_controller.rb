class SamplesController < ApplicationController
  before_filter :set_sample, :only => [:update, :destroy,
                                       :edit, :receive, :show]
  def index
    @samples = Sample.all.page params[:page]
  end

  def new
    @sample = Sample.new
  end

  def show
  end

  def edit
  end

  def update
    if @sample.update_attributes(sample_params)
      flash[:notice] = "Sample updated!"
      redirect_to @sample
    else
      render 'edit'
    end
  end

  def create
    @sample = Sample.new(sample_params)
    if @sample.save
      flash[:notice] = "Sample created!"
      redirect_to @sample
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

  def receive
  end

  private
  def sample_params
    params.require(:sample).permit(:name, :received_date, :receiver,
                                   :receiver_id, :express_number)
  end

  def set_sample
    @sample = Sample.where(id: params[:id]).first
    if not @sample
      flash[:alert] = "Sample not found!"
      redirect_to root_path
    end
  end
end
