class Notification < ApplicationRecord
  enum level: [:warning, :danger]

  belongs_to :status
  has_one :device, through: :status

  scope :active, -> { where(dismissed: false) }
end
