class TasksController < ApplicationController

  before_action :require_user_logged_in
  before_action :correct_user, only: [:show,:update,:edit,:destroy]
  
  #include SessionsHelper
  
  def index
   @tasks = current_user.tasks
  end

  def show
    #before_actionにより事前にcorrect_userが実行されて @taskが定義される。
    #この値を使用される。
    #参考箇所：カリキュラム8.7 ログイン要求処理
    #before_action では only: で指定されたアクションに対して、事前処理を
    #設定できます。
    
    #【レビュー指摘】下記不要な記述をしていた。
    #@task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
#指摘により削除だが後日質問    @task = Task.new(task_params)
#指摘により削除だが後日質問    @task.user_id = current_user.id

    @task = current_user.tasks.build(task_params)

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
    @task.destroy
    flash[:success] = 'タスク は正常に削除されました'
    redirect_to tasks_url
  end
  
  private

  # Strong Parameter
  def task_params
    params.require(:task).permit(:content, :status, :user_id)
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
end
