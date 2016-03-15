require 'rails_helper'

RSpec.describe "Appointments", type: :request do
  before { host! "api.example.com" }
  
  describe "GET /appointments" do
    before do 
      Appointment.create!(
        start_time: Time.strptime("11/1/16 7:00", "%m/%d/%y %H:%M"), 
        end_time: Time.strptime("11/1/16 8:00", "%m/%d/%y %H:%M")
        )
      Appointment.create!(
        start_time: Time.strptime("5/1/16 7:00", "%m/%d/%y %H:%M"), 
        end_time: Time.strptime("5/1/16 7:00", "%m/%d/%y %H:%M")
        )
      Appointment.create!(
        start_time: Time.strptime("11/1/16 2:00", "%m/%d/%y %H:%M"), 
        end_time: Time.strptime("11/1/16 3:00", "%m/%d/%y %H:%M")
        )
    end

    it "returns all appointments" do
      get "/appointments"
      expect(response).to have_http_status(200)
      expect(response.body).not_to be_empty
    end

    it "returns all appointments in a date range" do
      get "/appointments",
      { date_range: 
        { start_time: Time.strptime("11/1/16 6:00", "%m/%d/%y %H:%M"),
          end_time: Time.strptime("11/1/16 8:00", "%m/%d/%y %H:%M")
        }
      }.to_json,
      { "Accept" => Mime::JSON, 
        "Content-Type" => Mime::JSON.to_s 
      }

      expect(response).to have_http_status(200)
      appointments = JSON.parse(response.body, symbolize_names: true)
      p appointments
      expect(appointments.length).to eq(1)
    end
  end

  describe "GET /appointments/:id" do
    before { @appointment = Appointment.create!(start_time: "11/1/16 9:00", end_time: "11/1/16 9:30") }

    it "returns the appointment by id" do
      get "/appointments/#{@appointment.id}"
      expect(response).to have_http_status(200)
      appointment = JSON.parse(response.body, symbolize_names: true)
      expect(appointment[:start_time]).to eq(@appointment.start_time.as_json)
    end
  end
end
