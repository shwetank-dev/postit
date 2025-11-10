class User < ApplicationRecord
  has_many :posts
  has_many :comments
  has_many :votes

  has_secure_password

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, length: {minimum: 3}, on: :create

  def admin?
    self.role == 'admin'
  end
end