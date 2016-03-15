require 'rails_helper'

RSpec.describe "Appointments", type: :request do
  before { host! 'api.example.com' }

  describe "POST /appointments" do

    it "creates an appointment" do
      post '/appointments',
      { 
        appointment:
        { 
          start_time: "11/1/13 9:00", 
          end_time: "11.1.13 9:30"
        }
      }.to_json,
      { 
        "Accept" => Mime::JSON, 
        "Content-Type" => Mime::JSON.to_s 
      }

      expect(response).to have_http_status(201)

      appointment = JSON.parse(response.body, symbolize_names: true)
      expect(response.location).to eq(api_appointment_url(appointment[:id]))
    end
  end
  
end