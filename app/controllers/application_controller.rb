class ApplicationController < ActionController::Base
  include Sessions

  def authenticate_user
    redirect_to login_path, notice: t('views.not_login') unless current_user
  end
end
