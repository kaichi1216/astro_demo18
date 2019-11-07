class ApplicationController < ActionController::Base
  include SessionsHelper

  def authenticate_user
    unless current_user
      return redirect_to login_path, notice: "還沒登入喔"
    end
  end
end
