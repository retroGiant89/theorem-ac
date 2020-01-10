class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.integer :level
      t.string :message
      t.boolean :dismissed, null: false, default: false
      t.references :status, null: false, foreign_key: true

      t.timestamps
    end
  end
end
