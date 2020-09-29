class BoatsController < ApplicationController
  def index
    @boats = Boats.all
  end

  def search
    search_term = params["query"]
    search_term.capitalize! if search_term.class == String
    @boats = Boat.search_by_boat(search_term)
    @boats += search_after_address(search_term)
    @boats = @boats.uniq
    @boats
  end

  private

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
