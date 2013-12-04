class ProjectsController < ApplicationController

  include Pundit
  after_filter :verify_authorized

  def new
    @project = Project.new
    authorize @project
  end

  def create
    @project = Project.new(project_params)
    authorize @project
    if @project.save
      flash[:success] = 'Successfully saved new project.'
      redirect_to project_path(@project)
    else
      render 'new'
    end
  end

  def show
    @project = Project.find(params[:id])
    @client = @project.client
    authorize @project
  end

  def index
    @projects = Project.all
    authorize @project
  end

  def edit
    @project = Project.find(params[:id])
    authorize @project
  end

  def update
    @project = Project.find(params[:id])
    authorize @project
    if @project.update_attributes(project_params)
      flash[:success] = 'Project updated.'
      redirect_to project_path(@project)
    else
      render 'edit'
    end
  end

  def destroy
    project = Project.find(params[:id])
    authorize project
    project.destroy
    flash[:success] = 'Project destroyed.'
    redirect_to projects_url
  end

  private

    def project_params
      params.require(:project).permit(:client_id, :name, :start_date, :end_date, :desc, :notes )
    end
end