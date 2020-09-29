class BoatsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index search]

  def index
    search
  end

  def update
  end
    private

  def search
    # This will search for any complete word within the boat or address field - currently partial maches are not supported.
    search_term = params['query']
    @boats = Boat.search_by_boat(search_term)
    @boats += search_after_address(search_term)
    @boats = @boats.uniq
    @boats
  end



  def search_after_address(search_term)
    search_term.capitalize! if search_term.class == String
    addresses = Address.search_by_address(search_term)
    additional_boats = []
    addresses.each do |a|
      boat = Boat.where("#{a.id} = address_id")
      additional_boats << boat
    end
    additional_boats
  end


end
