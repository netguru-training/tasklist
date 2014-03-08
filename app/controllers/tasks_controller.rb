class TasksController < ApplicationController
  expose(:lists) { List.all }
  expose(:list)
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
    task.completion = true
    task.save
    redirect_to task.list, notice: 'Task marked as completed'
  end

  private

    def task_params
      params.require(:task).permit(:completion, :description)
    end


end
