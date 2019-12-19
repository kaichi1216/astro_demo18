class SessionsController < ApplicationController
  before_action :find_user, :only => [:create]
  #登入頁面
  def new
    redirect_to root_path if current_user
  end
  #登入建立session
  def create
    if @user && @user.authenticate(params[:session][:password])
      login @user
      redirect_to root_path, notice: t('session.success')
    else  
      redirect_to login_path, notice: t('session.unsuccess')
    end
  end
  #登出 刪除session
  def destroy
    logout
    redirect_to login_path, notice: t('session.signout')
  end

  private

  def find_user
    @user = User.find_by(email: params[:session][:email].downcase)
  end
end
