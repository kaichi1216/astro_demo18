class Admin::BaseController < ApplicationController
  before_action :authenticate_admin
  # 使用admin 版型
  layout "admin"

  # 如果不是管理者的話 導回首頁頁面
  def authenticate_admin
    redirect_to root_path, notice: t('admin.not_admin') unless is_admin?
  end

end