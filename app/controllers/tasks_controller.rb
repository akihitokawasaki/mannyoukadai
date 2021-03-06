class TasksController < ApplicationController
  before_action :authenticate_user
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  PER = 5
  def index
    if params[:sort_deadline]
      @tasks = current_user.tasks.find(params[:id]).all.order(deadline: :asc).page(params[:page]).per(PER)
    elsif params[:sort_priority]
      @tasks = current_user.tasks.find(params[:id]).all.order(priority: :asc).page(params[:page]).per(PER)
    elsif params[:name] && params[:status] && params[:label_ids]
      @status = params[:status].to_i
      @label_id = params[:label_ids]
      @tasl_labels = TaskLabel.where(label_id: @label_id).pluck(:task_id)
      @tasks = Task.where(id: @tasl_labels).page(params[:page]).per(PER)
    elsif params[:name].present?
      @tasks = current_user.tasks.find(params[:id]).where(name: params[:name]).page(params[:page]).per(PER)
    if params[:status].present?
      @tasks = current_user.tasks.find(params[:id]).where(name: params[:name]).where(status: params[:status]).page(params[:page]).per(PER)
    end  
    elsif params[:status].present?
      @tasks = current_user.tasks.find(params[:id]).where(status: params[:status]).page(params[:page]).per(PER)
    else
      puts params[:sort_deadline]
      @tasks = current_user.tasks.order(created_at: :desc).page(params[:page]).per(PER)
    end
  end

  def show
  end

  def new
    @task = current_user.tasks.build
  end

  def edit
  end

  def create
    @task = current_user.tasks.build(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:name, :description, :deadline, :priority, :status, label_ids: [])
    end
end
