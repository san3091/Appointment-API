json.array!(@appointments) do |appointment|
  json.extract! appointment, :id, :start_time, :end_time, :first_name, :last_name
  json.url api_appointment_url(appointment, format: :json)
end
