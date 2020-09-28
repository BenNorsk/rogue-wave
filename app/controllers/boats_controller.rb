class BoatsController < ApplicationController
  def index
    @boats = Boats.all
  end
end
