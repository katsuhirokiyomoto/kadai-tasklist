class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :set_task, only: [:show, :edit, :update, :destroy] 
  before_action :correct_user, only: [:show, :edit, :destroy]
  
  def index
    @user=current_user
    @tasks=@user.tasks.order(created_at: :desc).page(params[:page]).per(3)
    
  end
 
  def show
  end

  def new
    @user=current_user
    @task=@user.tasks.new
  end
  
  def create
    @user=current_user
    @task=@user.tasks.new(task_params)
    
    if @task.save
      flash[:success]='タスクが正常に作成されました'
      redirect_to @task
    else
      flash.now[:danger]='タスクが作成されませんでした'
      render :new
    end
  end

  def edit
  end
  
  def update
    if @task.update(task_params)
      flash[:success]='タスクは正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger]='タスクが更新されませんでした'
      render :edit
    end
  end

  def destroy
    @task.destroy
    flash[:success]='タスクが正常に消去されました'
    redirect_to tasks_url
  end
  
  def set_task
    @task=current_user.tasks.find_by(id: params[:id])
  end
  
  def correct_user
    @task=current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_path
    end
  end
# Strong Parameter
  def task_params
    params.require(:task).permit(:content, :status)
  end

end
