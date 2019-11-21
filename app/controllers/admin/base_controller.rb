class Admin::BaseController < ApplicationController
  before_action :authenticate_admin
  layout "admin"


  def authenticate_admin
    redirect_to root_path, notice: t('admin.not_admin') unless self.is_admin?
  end

end