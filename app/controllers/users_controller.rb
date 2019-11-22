class UsersController < ApplicationController
  before_action :authenticate_user, only: %i[show edit update]
  before_action :find_user, only: [:show, :edit, :update]
  before_action :check_user, only: [:edit, :update]
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
  end
  
  def update
    if @user.update(filter_params)
      redirect_to user_path(@user), notice: t('user.edit_t')
    else  
      render :edit, notice: t('user.edit_f')
    end
  end
  
  def destroy

  end


  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :role)
  end

  def find_user
    @user = User.find_by(id: params[:id])
  end

  def check_user
    redirect_to root_path unless @user
  end

  def filter_params
    user_params.select { |k, v| !v.blank? }
  end

end
