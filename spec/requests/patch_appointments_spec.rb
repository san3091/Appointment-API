require 'rails_helper'

RSpec.describe "Appointments", type: :request do
  
  describe "PATCH '/appointments" do
    before { @appointment = Appointment.create!(start_time: "11/1/16 3:00", end_time: "11/1/16 4:00") }

    it "updates appointment" do
      patch api_appointment_url(@appointment),
      { appointment:
        { start_time: "11/1/16 9:00", 
          end_time: "11/1/16 9:30"
        }
      }.to_json,
      { "Accept" => Mime::JSON, 
        "Content-Type" => Mime::JSON.to_s 
      }

      expect(@appointment.reload.start_time).not_to eq(@appointment)
    end

  end
end
