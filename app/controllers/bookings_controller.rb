class BookingsController < ApplicationController
  # skip_before_action :authenticate_user!, only: %i[home playground]
  def create
    if check_booking_dates
      @booking = Booking.new(booking_params)
      @booking.user = current_user
      @booking.boat = Boat.find(params["boat_id"])

      if @booking.save
        flash[:alert] = "Booking request sent"
        redirect_to user_bookings_path
        # redirect_to boat_path(@booking.boat)
      else
        redirect_to boat_path(@booking.boat)
      end
    else
      flash[:alert] = "Booking date-time not valid, please try again"
      redirect_to boat_path(Boat.find(params["boat_id"]))
    end
  end

  private

  def check_booking_dates
  # convert form params to ruby dates
  begin
  start_date = DateTime.new(booking_params["start_date(1i)"].to_i,
                            booking_params["start_date(2i)"].to_i,
                            booking_params["start_date(3i)"].to_i,
                            booking_params["start_date(4i)"].to_i,
                            booking_params["start_date(5i)"].to_i)

  end_date = DateTime.new(booking_params["end_date(1i)"].to_i,
                            booking_params["end_date(2i)"].to_i,
                            booking_params["end_date(3i)"].to_i,
                            booking_params["end_date(4i)"].to_i,
                            booking_params["end_date(5i)"].to_i)
  rescue ArgumentError
    return false
  end

  start_date < end_date && start_date > Date.today
  end

  def booking_params
    params.require(:booking).permit(:boat_id, :start_date, :end_date)
  end
end
