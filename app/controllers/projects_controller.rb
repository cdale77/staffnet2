class ProjectsController < ApplicationController

  #include Pundit
  #after_filter :verify_authorized

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      flash[:success] = 'Successfully saved new project.'
      redirect_to project_path(@project)
    else
      render 'new'
    end
  end

  def show

  end

  def index

  end

  def edit

  end

  def update

  end

  def destroy

  end

  private

    def project_params
      params.require(:project).permit(:client_id, :name, :start_date, :end_date, :desc, :notes )
    end
end