class Admin::UsersController < Admin::BaseController
  before_action :find_user, only: %i[edit update show destroy]
  before_action :search_user_tasks, only: [:show]

  def index
    @users = User.page(params[:page]).per(20)
  end
  
  def show
    @tasks = @q.result(distinct: true).page(params[:page]).per(10)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: t('user.signup_t')
    else 
      render :new
    end
  end

  def edit
  end

  def update
    if @user.toggle!(filter_params)
      redirect_to user_path(@user), notice: t('user.edit_t')
    else  
      render :edit, notice: t('user.edit_f')
    end
  end

  def destroy
    if @user.destroy
      redirect_to admin_users_path, notice: t('admin.destroy.notice')
    else  
      redirect_to admin_users_path, notice: "#{@user.errors[:base]}"
    end
  end

  private

  def find_user
    @user = User.find_by(id: params[:id])
    redirect_to admin_root_path if @user.nil?
  end

  def search_user_tasks
    @q = Task.includes(:user).where(users: {id: @user.id}).ransack(params[:q])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :role)
  end

  def filter_params
    user_params.select { |k, v| !v.blank? }
  end
end
