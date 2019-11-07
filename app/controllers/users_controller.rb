class UsersController < ApplicationController
  before_action :authenticate_user, only: %i[show edit update]
  before_action :find_user, :only => [:show, :edit, :update]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login @user
      redirect_to root_path, notice: t('views.user.create')
    else 
      render :new
    end
  end

  
  def show
  end
  
  def edit
    unless @user
      redirect_to root_path
    end
  end
  
  def update
    unless @user
      redirect_to root_path
    end

    if @user.update(user_params)
      redirect_to user_path(@user), notice: t('user.edit_t')
    else  
      render :edit, notice: t('user.edit_f')
    end
  end
  
  def destroy

  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def find_user
    @user = User.find_by(id: params[:id])
  end
end
