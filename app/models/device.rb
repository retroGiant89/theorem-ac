class Device < ApplicationRecord
  has_many :statuses

  before_create :add_token

  def add_token
    self.token = SecureRandom.hex(10)
  end
end
