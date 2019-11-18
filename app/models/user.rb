class User < ApplicationRecord
  has_many :tasks, dependent: :destroy
  validates :username, presence: true
  validate_email = /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  validates :email, presence: true, format: { with: validate_email }
  validates_uniqueness_of :email, :message => "你的 Email 重複了"
  validates :password, presence: true, length: { minimum: 6 }
  before_destroy :final_admin
  has_secure_password

  #檢查使用者身份是不是admin 如果admin剩最後一個 無法被刪除
  def final_admin
    return unless self.role == 'admin'
      if User.where(role: 'admin').count == 1
        halt msg: "最後一位使用者無法被刪除"
      end
  end

end
