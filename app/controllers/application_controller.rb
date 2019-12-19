class ApplicationController < ActionController::Base
  include Sessions
  private
  helper_method :current_user
  helper_method :admin?
  #檢查是否登入 沒登入的話導入登入畫面
  def authenticate_user
    redirect_to login_path, notice: t('views.not_login') unless current_user
  end
end
