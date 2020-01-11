class Device < ApplicationRecord
  has_many :statuses

  before_create :add_token

  validates :serial_number, :firmware_version, presence: true

  def add_token
    self.token = SecureRandom.hex(10)
  end
end
