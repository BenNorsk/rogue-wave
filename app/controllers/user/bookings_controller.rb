class User::BookingsController < ApplicationController
  def index
    @bookings = Booking.where("user_id = #{current_user.id}")
  end

  def update
    @booking = Booking.find(params["id"])
    if @booking.update(booking_params)
      redirect_to("/playground", notice: "Your booking status has been successfully updated.")
    else
      redirect_to("/playground", alert: "Your booking status could not have been updated.")
    end

  end

  private

  def booking_params
    params.require(:booking).permit(:status)
  end
end
