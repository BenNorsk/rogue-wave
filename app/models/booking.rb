class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :boat

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :status, inclusion: { in: %w(pending accepted cancelled),
  message: "%{value} is not a valid status, must be 'pending', 'accepted' or 'cancelled'" }
end
