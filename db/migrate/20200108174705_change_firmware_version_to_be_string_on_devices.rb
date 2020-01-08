class ChangeFirmwareVersionToBeStringOnDevices < ActiveRecord::Migration[6.0]
  def change
    change_column :devices, :firmware_version, :string
  end
end
