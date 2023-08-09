class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, confirmation: { case_sensitive: false }
  validates :password, presence: true
  validates :password_confirmation, presence: true
  validates :api_key, presence: true, on: :save

  has_secure_password
  has_secure_token :api_key

  has_many :favorites
end
