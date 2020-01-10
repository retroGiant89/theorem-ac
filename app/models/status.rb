class Status < ApplicationRecord
  belongs_to :device
  has_many :notifications

  after_create :generate_notifications

  def generate_notifications
    notifications.create(level: :danger, message: 'carbon_monoxide_high') if carbon_monoxide > 9
    notifications.create(level: :danger, message: health_status) if health_status == 'gas_leak'
    notifications.create(level: :warning, message: health_status) if ['needs_service','needs_new_filter'].include? health_status
  end
end
