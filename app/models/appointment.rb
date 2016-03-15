class Appointment < ActiveRecord::Base
  belongs_to :patient
  validates :start_time, presence: true
  validates :end_time, presence: true

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
    Appointment.where(start_time: (start_time..end_time)).where(end_time: (start_time..end_time))
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
end
