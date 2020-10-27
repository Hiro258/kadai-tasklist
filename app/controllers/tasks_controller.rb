class TasksController < ApplicationController
#  before_action :require_user_logged_in, only: [:index, :show]

   before_action :require_user_logged_in
  
  include SessionsHelper
  
  def index
    
#  @tasks = Task.new(task_params)
#  @tasks.user_id = current_user.id
#  @tasks=Task.all
#  @task  = current_user.tasks.build
#  @tasks = current_user.tasks.order(id: :desc).page(params[:page])

   @tasks = current_user.tasks
   


  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create

    @task = Task.new(task_params)
    @task.user_id = current_user.id

    if @task.save
      flash[:success] = 'タスクが正常に投稿されました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスクが投稿されませんでした'
      render :new
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
     @task = Task.find(params[:id])

    if @task.update(task_params)
      flash[:success] = 'タスク は正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスク は更新されませんでした'
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    flash[:success] = 'タスク は正常に削除されました'
    redirect_to tasks_url
  end
  
  private

  # Strong Parameter
  def task_params
    params.require(:task).permit(:content, :status, :user_id)
  end
  
end
