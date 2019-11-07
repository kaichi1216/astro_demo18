class SessionsController < ApplicationController
  def new
    if current_user
      redirect_to root_path
    end
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      login user
      redirect_to root_path, notice: t('user.signup_t')
    else  
      render :new, notice: t('user.signup_f')
    end
  end

  def destroy
    logout
    redirect_to root_path, notice: t('session.signout')
  end
end
