class BoatsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @boats = Boat.all
    @query = params['query']
    @boats = Boat.global_search(@query) if @query.present?

    @markers = @boats.map do |boat|
      {
        lat: boat.address.latitude,
        lng: boat.address.longitude
      }
    end
  end

  def show
    @boat = Boat.find(params["id"])

    @markers = [@boat].map do |boat|
      {
        lat: boat.address.latitude,
        lng: boat.address.longitude
      }
    end
  end


  # def search
  #   # This will search for any complete word within the boat or address field - currently partial maches are not supported.
  #   search_term = params['query']
  #   @boats = Boat.search_by_boat(search_term)
  #   @boats += search_after_address(search_term)
  #   @boats = @boats.uniq
  #   @boats
  # end



  # def search_after_address(search_term)
  #   search_term.capitalize! if search_term.class == String
  #   addresses = Address.search_by_address(search_term)
  #   additional_boats = []
  #   addresses.each do |a|
  #     boat = Boat.where("#{a.id} = address_id")
  #     additional_boats << boat
  #   end
  #   additional_boats
  # end
  def update; end
end
