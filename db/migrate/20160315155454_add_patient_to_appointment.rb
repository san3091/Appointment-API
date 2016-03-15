class AddPatientToAppointment < ActiveRecord::Migration
  def change
    add_column :appointments, :first_name, :string
    add_column :appointments, :last_name, :string
  end
end
