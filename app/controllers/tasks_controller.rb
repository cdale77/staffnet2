class TasksController < ApplicationController

  #include Pundit
  #after_filter :verify_authorized

  def new
    @task = Task.new
    #authorize @task
  end

  def create
    @task = Task.new(task_params)
    #authorize @task
    if @task.save
      flash[:success] = 'Successfully saved new task.'
      redirect_to task_path(@task)
    else
      render 'new'
    end
  end

  def show
    @task = Task.find(params[:id])
    @project = @task.project
    #authorize @task
  end

  def index
    @tasks = Task.all
    #authorize @tasks
  end

  def edit
    #@task = Task.find(params[:id])
    #authorize @task
  end

  def update
    #@task = Task.find(params[:id])
    #authorize @task
    #if @task.update_attributes(task_params)
    #  flash[:success] = 'Task updated.'
    #  redirect_to task_path(@task)
    #else
    #  render 'edit'
    #end
  end

  def destroy
    #task = Task.find(params[:id])
    #authorize task
    #task.destroy
    #flash[:success] = 'Task destroyed.'
    #redirect_to tasks_url
  end

  private

  def task_params
    params.require(:task).permit(:shift_id, :project_id, :name, :hours, :desc, :notes )
  end
end