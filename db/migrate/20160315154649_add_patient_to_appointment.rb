class AddPatientToAppointment < ActiveRecord::Migration
  def change
    add_foreign_key :patients, :appoitnment, index: true
  end
end
