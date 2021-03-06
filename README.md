# Appointment API

Api used for scheduling appointments.

All endpoints return json

## Endpoints

#### GET 
  + /appointments
    - returns all appointments
  + /appointments/1 
    - returns appointment with id 1
  + /appointments?date_range[start_time]=11/1/16 5:00&date_range[end_time]=11/1/16 10:00
    - returns all appointments on 11/1/16 scheduled between 5 and 10
  + /appointments?first_name=santiago
    - returns all appointments scheduled by patients with first name santiago
  + /appointments?last_name=quintana
    - returns all appointments schedules by patiens with last name quintana
  + /appointments?first_name=santiago&last_name=quintana
    - returns all appointments schedules by santiago quintana

#### POST 
  + /appointments
    - creates an appointment if the dates are in the future and they don't overlap with other appointments.

#### DELETE 
  + /appointments/1
    - deletes appointment with id 1

#### PATCH 
  + /appointments/1
    - updates attributes for appointment 1

## Testing

Database can be seeded from included csv file by calling `rake import`