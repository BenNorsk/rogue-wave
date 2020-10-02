class BookingsController < ApplicationController
  # skip_before_action :authenticate_user!, only: %i[home playground]
  def create

    if check_booking_dates_validity(converted_dates)
      @booking = Booking.new(converted_dates)
      @booking.user = current_user
      @booking.message = params["booking"]["message"]
      @booking.boat = Boat.find(params["boat_id"])
      @booking.status = "pending"
      if @booking.save
        flash[:alert] = "Booking request sent successfully"
        redirect_to user_bookings_path
        # redirect_to boat_path(@booking.boat)
      else
        redirect_to boat_path(@booking.boat)
      end
    else
      redirect_to boat_path(Boat.find(params["boat_id"]))
    end
  end

  private

  def converted_dates
  # datepickr range will return something like '2020-10-13 to 2020-10-21'
  # need to get the start and end date from it
    pattern = /(?<start_date>\d{4}-\d{2}-\d{2}) to (?<end_date>\d{4}-\d{2}-\d{2})|(?<start_end_date>\d{4}-\d{2}-\d{2})/
    date_range = booking_params[:start_date].match(pattern)
    if !date_range["start_date"].nil?
    output = {
      start_date: Date.parse( date_range["start_date"] ),
      end_date: Date.parse( date_range["end_date"] )
    }
    elsif !date_range["start_end_date"].nil?

    output = {
      start_date: Date.parse( date_range["start_end_date"] ),
      end_date: Date.parse( date_range["start_end_date"] )
    }
    end
  end

  def check_booking_dates_validity(dates)
  # convert form params to ruby date
    if dates[:start_date] < Date.today
      flash[:alert] = "Rental cannot start in the past"
      false
    elsif dates[:start_date] > dates[:end_date]
      flash[:alert] = "End dates must be after the start date"
      false
    elsif dates[:start_date] == Date.today
      flash[:alert] = "Rental cannot start on the same day as booking"
      false
    else
      true
    end
  end

  def booking_params
    params.require(:booking).permit(:boat_id, :start_date, :end_date, :status, :message)
  end
end
