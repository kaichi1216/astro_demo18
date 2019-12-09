class ErrorsController < ApplicationController

  def show
    render status_code.to_s, status: status_code
  end

  
protected
  #錯誤頁面導向
  def status_code
    params[:code] || 500
  end

end