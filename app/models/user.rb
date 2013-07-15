class User < ActiveRecord::Base
  validates :name, presence: true,
                   length:     { maximum: 50 },
                   format:     { with: /\A[0-9a-z_]+\z/i },
                   uniqueness: { case_sensitive: false }

  before_save { self.email = email.downcase }
  validates :email, presence:   true,
                    format:     { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }

  validates :api_token, length: { maximum: 40 },
                        uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password, length: { minimum: 6 }
end
