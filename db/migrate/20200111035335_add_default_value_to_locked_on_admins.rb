class AddDefaultValueToLockedOnAdmins < ActiveRecord::Migration[6.0]
  def change
    change_column_null :admins, :locked, false
    change_column_default :admins, :locked, false
  end
end
