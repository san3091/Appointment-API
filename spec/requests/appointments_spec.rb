require 'rails_helper'

RSpec.describe "Appointments", type: :request do
  before { host! "api.example.com" }
  
  describe "GET /appointments" do
    before { Appointment.create!(start_time: Time.parse("11/1/13 7:00"), end_time: Time.parse("11.1.13 8:00")) }

    it "retrieves all appointments" do
      get "/appointments"
      expect(response).to have_http_status(200)
      expect(response.body).not_to be_empty
    end
  end

  describe "GET /appointments/:id" do
    before { @appointment = Appointment.create!(start_time: Time.parse("11/1/13 9:00"), end_time: Time.parse("11.1.13 9:30")) }

    it "retrieves the appointment by id" do
      get "/appointments/#{@appointment.id}"
      expect(response).to have_http_status(200)
      appointments = JSON.parse(response.body, symbolize_names: true)
      p appointments
    end
  end

end
