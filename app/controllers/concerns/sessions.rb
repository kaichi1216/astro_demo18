module Sessions
  extend ActiveSupport::Concern
  #登入
  def login(user)
    session[:user_id] = user.id
  end
  #登入的使用者
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end
  #登出
  def logout
    session.delete(:user_id)
    @current_user = nil
  end
  #是否是管理員 使用 &. 不符合的話 會回傳 nil 而不會噴錯
  def admin?
    current_user&.role == 'admin'
  end
end