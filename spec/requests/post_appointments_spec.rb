require 'rails_helper'

RSpec.describe "Appointments", type: :request do
  before { host! 'api.example.com' }

  describe "POST /appointments" do

    it "creates an appointment with Time objects" do
      post '/appointments',
        { 
          appointment:
            { start_time: Time.parse("11/1/13 9:00"), end_time: Time.parse("11.1.13 9:30") }
        }.to_json,
        { "Accept" => Mime::JSON, "Content-Type" => Mime::JSON.to_s }
      expect(response).to have_http_status(201)
    end
  end
  
end