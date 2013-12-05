class TaskTypesController < ApplicationController
  #include Pundit
  #after_filter :verify_authorized

  def new
    @task_type = TaskType.new
    #authorize @task
  end

  def create
    @task_type = TaskType.new(task_type_params)
    #authorize @task
    if @task_type.save
      flash[:success] = 'Successfully saved new task type.'
      redirect_to task_types_url
    else
      render 'new'
    end
  end

  def index
    @task_types = TaskType.all
    #authorize @tasks
  end

  def edit
    #@task_type = TaskType.find(params[:id])
    #authorize @task
  end

  def update
    #@task_type = TaskType.find(params[:id])
    #authorize @task
    #if @task_type.update_attributes(task_type_params)
    #  flash[:success] = 'Task type updated.'
    #  redirect_to task_type_path(@task_type)
    #else
    #  render 'edit'
    #end
  end

  def destroy
    #task_type = TaskType.find(params[:id])
    #authorize task
    #task_type.destroy
    #flash[:success] = 'Task type destroyed.'
    #redirect_to task_types_url
  end

  private

  def task_type_params
    params.require(:task_type).permit(:name, :desc)
  end
end