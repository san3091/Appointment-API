class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false
      t.string :first_name
      t.string :last_name

      t.timestamps null: false
    end
    add_index :appointments, :start_time, unique: true
    add_index :appointments, :end_time, unique: true
  end
end
