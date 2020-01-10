class AddTokenToDevices < ActiveRecord::Migration[6.0]
  def change
    add_column :devices, :token, :string
  end
end
