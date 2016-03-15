class AddCommentsToAppointment < ActiveRecord::Migration
  def change
    add_column :appointments, :comments, :string
  end
end
