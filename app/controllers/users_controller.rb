class UsersController < ApplicationController
  def index
    @user = User.find_by(id: params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path, notice: t('views.user.create')
    else 
      render :new
    end
  end

  def show

  end

  def edit

  end
  
  def update

  end

  def destroy

  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
