require 'csv'
desc "Imports a CSV file into an ActiveRecord table"
task :import, [:filename] => :environment do    
    CSV.foreach('./db/appt_data.csv', :headers => true) do |row|
      begin
        Appointment.create!(row.to_hash)
      rescue
        next
      end
    end
end