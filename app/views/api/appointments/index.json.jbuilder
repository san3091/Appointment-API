json.array!(@appointments) do |appointment|
  json.extract! appointment, :id, :start_time, :end_time
  json.url api_appointment_url(appointment, format: :json)
end
