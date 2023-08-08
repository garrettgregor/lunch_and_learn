
class User < ApplicationRecord
  after_create :set_api_key

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  validates :api_key, presence: true, on: :save

  has_secure_password

  private

  def set_api_key
    self.api_key = ApiKey.generator
  end
end
