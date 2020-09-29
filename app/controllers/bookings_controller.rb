class BookingsController < ApplicationController
  # skip_before_action :authenticate_user!, only: %i[home playground]
  def index
    @bookings = Booking.where("user_id = #{current_user.id}")
    raise
  end
end
