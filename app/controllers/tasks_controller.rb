class TasksController < ApplicationController
    def index
        @tasks = Task.all
    end

    def new
        @task = Task.new
    end

    def create
        @task = Task.new(task_params)
        if @task.save(validate: false) 
            redirect_to tasks_path, notice: "新增任務成功"
        else  
            render :new
        end
    end

    def show
        @task = Task.find_by(id: params[:id])
    end

    def edit
        @task = Task.find_by(id: params[:id])
    end

    def update
        @task = Task.find_by(id: params[:id])
        if @task.update(task_params)
            redirect_to tasks_path, notice: "編輯成功"
        else  
            render :edit
        end
    end

    def destroy
        @task = Task.find_by(id: params[:id])
        @task.destroy
        redirect_to tasks_path, notice: "刪除成功"
    end



    
    private
    
    def task_params
        params.require(:task).permit(:username, :task, :content)
    end


end
