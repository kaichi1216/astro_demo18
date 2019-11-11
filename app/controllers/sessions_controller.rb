class SessionsController < ApplicationController
  before_action :find_user, :only => [:create]
  def new
    redirect_to root_path if current_user
  end

  def create
    if @user && @user.authenticate(params[:session][:password])
      login @user
      redirect_to root_path, notice: t('user.signup_t')
    else  
      render :new, notice: t('user.signup_f')
    end
  end

  def destroy
    logout
    redirect_to root_path, notice: t('session.signout')
  end

  private

  def find_user
    @user = User.find_by(email: params[:session][:email].downcase)
  end
end
