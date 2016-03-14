class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps null: false
    end
    add_index :appointments, :start_time, unique: true
    add_index :appointment, :end_time, unique: true
  end
end
