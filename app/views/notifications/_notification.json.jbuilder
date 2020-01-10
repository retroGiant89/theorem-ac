json.extract! notification, :id, :level, :status, :dismissed, :created_at, :updated_at
json.url notification_url(notification, format: :json)
