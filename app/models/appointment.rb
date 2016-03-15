class Appointment < ActiveRecord::Base
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  def get_same_day_appts
    search_by_date(self.start_time.to_date)
  end

  def search_by_date(date)
    Appointment.where("start_time like ?", "%#{date}%") || false
  end

  def self.search_by_date_range(start_time, end_time)
    p start_time
    start_time = Time.strptime(start_time, "%m/%d/%y %H:%M")
    end_time = Time.strptime(end_time, "%m/%d/%y %H:%M")
    Appointment.where(start_time: (start_time..end_time)).or(end_time: (start_time..end_time))
  end

  # Check for overlap in appointment times
  def overlap?
    matches = self.get_same_day_appts
    matches.each do |appt|
      if time_overlap?(self.start_time, appt) || time_overlap?(self.end_time, appt)
        return true
      end
    end
    false
  end

  # Refactor the specific time overlap check
  def time_overlap?(time, appt)
    time.between?(appt.start_time, appt.end_time)
  end

  # Search by first or last name
  def self.search_by_name(first_name, last_name)
    @appointments = Appointment.where("first_name = ? or last_name = ?", first_name, last_name)
  end
end
