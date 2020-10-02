class User::BookingsController < ApplicationController
  def index
    @bookings = Booking.where("user_id = #{current_user.id}")
    @boat_bookings = []
    current_user.boats.ids.each do |boat_id|
      @boat_bookings << Booking.where("boat_id = #{boat_id}")
    end
  end

  def update
    @booking = Booking.find(params["id"])
    if @booking.update(booking_params)
      redirect_to( user_bookings_path, notice: "Your booking status has been successfully updated.")
    else
      redirect_to( user_bookings_path, alert: "Something went wrong. Your booking status has not been updated.")
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:status)
  end
end
