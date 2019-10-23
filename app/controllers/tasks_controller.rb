class TasksController < ApplicationController
  before_action :find_task, :only => [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.order(created_at: :desc)
    #之後會改成分頁形式，先暫時用 all
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.user = User.first
    #這裡暫時沒有建立User 
    if @task.save 
      redirect_to tasks_path, notice: t('.notice')
    else  
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: t('.notice')
    else  
      render :edit
    end
  end

  def destroy
    if @task.destroy
      notice = t('.notice')
    else 
      notice = t('.not_success')
    end
      redirect_to tasks_path, notice: notice
  end



    
  private
    
  def task_params
    params.require(:task).permit(:task, :content)
  end

  def find_task
    @task = Task.find_by(id: params[:id])
  end

end
