class User < ApplicationRecord
  has_many :tasks
  validates :username, presence: true
  validate_email = /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  validates :email, presence: true, format: { with: validate_email }
  validates_uniqueness_of :email, :message => "你的 Email 重複了"
  validates :password, presence: true, length: { minimum: 6 }
  has_secure_password
end
