class TasksController < ApplicationController
  before_action :find_task, :only => [:show, :edit, :update, :destroy, :start, :done]
  before_action :search_params, :only => [:index, :search]
  before_action :authenticate_user

  def index
    # @tasks = @q.result.ordered(sort_params).page(params[:page]).per(10)
    @tasks = @q.result.includes(:tags, :user).where(user: current_user.id).ordered(sort_params).page(params[:page]).per(10)
  end

  def search
    @tasks = @q.result(distinct: true).includes(:user, :tags).where(user: current_user.id).ordered_by_deadline.page(params[:page]).per(10)
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.user = current_user
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

  def start
    @task.start! if @task.pending?
    redirect_back(fallback_location: :root_path)
  end

  def done
    @task.done! if @task.completed?
    redirect_back(fallback_location: :root_path)
  end

    
  private
    
  def task_params
    params.require(:task).permit(:task, :content, :deadline, :state, :priority, {tag_items:[]})
  end

  def find_task
    @task = Task.find_by(id: params[:id])
  end

  def search_params
    @q = Task.ransack(params[:q])
  end

  def sort_params
    field, order = params[:sort].to_s.split('_')
    return unless field.in?(%w[state deadline priority])
    return unless order.in?(%w[asc desc])
  
    "#{field} #{order.upcase}"
  end

end
