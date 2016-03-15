module API
  class AppointmentsController < ApplicationController
    before_action :set_appointment, only: [:show, :edit, :update, :destroy]

    # GET /appointments
    # GET /appointments.json
    def index
      if date_range = params[:date_range]
        # return the appointments that are between the start and end time
        start_time = date_range[:start_time]
        end_time = date_range[:end_time]
        @appointments = Appointment.search_by_date_range(start_time, end_time)
      else 
        # return all appointments
        @appointments = Appointment.all
      end
      render json: @appointments
    end

    # GET /appointments/1
    # GET /appointments/1.json
    def show
      render json: @appointment
    end

    # POST /appointments
    # POST /appointments.json
    def create
      @appointment = Appointment.new(parsed_params)

      respond_to do |format|
        if invalid_time
          format.json { render json: @appointment.errors, status: :unprocessable_entity}
        else
          if @appointment.save
            format.json { render :show, status: :created, location: api_appointment_url(@appointment) }
          else
            format.json { render json: @appointment.errors, status: :unprocessable_entity }
          end
        end
      end
    end

    # PATCH/PUT /appointments/1
    # PATCH/PUT /appointments/1.json
    def update
      respond_to do |format|
        if invalid_time
          format.json { render json: @appointment.errors, status: :unprocessable_entity }
        else
          if @appointment.update(appointment_params)
            format.json { render :show, status: :ok, location: api_appointment_url(@appointment) }
          else
            format.json { render json: @appointment.errors, status: :unprocessable_entity }
          end
        end
      end
    end

    # DELETE /appointments/1
    # DELETE /appointments/1.json
    def destroy
      @appointment.destroy
      respond_to do |format|
        format.json { head :no_content }
      end
    end

    private

      def invalid_time
        @appointment.start_time.nil? || !@appointment.start_time.future? || @appointment.overlap?
      end

      # Parse sanitized params start and end time using Active Support
      def parsed_params
        start_time = appointment_params[:start_time]
        end_time = appointment_params[:end_time]
        appointment_params[:start_time] = Time.strptime(start_time, "%m/%d/%y %H:%M") unless start_time.nil?
        appointment_params[:end_time] = Time.strptime(end_time, "%m/%d/%y %H:%M") unless end_time.nil?
        appointment_params
      end

      # Use callbacks to share common setup or constraints between actions.
      def set_appointment
        @appointment = Appointment.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      # Lazy cache
      def appointment_params
        @appointment_params ||= params.require(:appointment).permit(:start_time, :end_time, :first_name, :last_name)
      end
  end
end