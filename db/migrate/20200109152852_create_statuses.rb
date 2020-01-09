class CreateStatuses < ActiveRecord::Migration[6.0]
  def change
    create_table :statuses do |t|
      t.float :temperature
      t.float :air_humidity
      t.integer :carbon_monoxide
      t.string :health_status
      t.datetime :collected_at
      t.references :device, null: false, foreign_key: true

      t.timestamps
    end
  end
end
