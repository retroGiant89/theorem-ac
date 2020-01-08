json.extract! device, :id, :serial_number, :firmware_version, :created_at, :updated_at
json.url device_url(device, format: :json)
