class ApplicationController < ActionController::Base
  private
  include Sessions
  helper_method :current_user
  helper_method :is_admin?

  def authenticate_user
    redirect_to login_path, notice: t('views.not_login') unless current_user
  end
end
