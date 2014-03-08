class TasksController < ApplicationController
  expose(:list) { current_user.lists.find(params[:list_id]) }
  expose(:tasks) { list.tasks }
  expose(:task, attributes: :task_params)

  def index
  end

  def new
  end

  def create
    if task.save
      redirect_to list
    else
      render :new
    end
  end

  def update
    if task.save
      redirect_to task.list, notice: 'Task was successfully added to the list'
    else
      render :edit
    end
  end

  def edit
  end

  def destroy
    task.destroy
  end

  def show
  end

  def complete
    task = Task.find(params[:id])
    task.update_attributes(completion: true)
    redirect_to task.list, notice: 'Task marked as completed'
  end

  def uncomplete
    task = Task.find(params[:id])
    task.update_attributes(completion: false)
    redirect_to task.list, notice: 'Task marked as not completed'
  end

  private

    def task_params
      params.require(:task).permit(:completion, :description)
    end


end
