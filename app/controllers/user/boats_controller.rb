class User::BoatsController < ApplicationController


  def index
    if !params["boat_id"].nil?
      @user = current_user
      @selected_boat = Boat.find(params["boat_id"])
    else
      @user = current_user
    end
  end

  def new
    @boat = Boat.new
    @boat.build_address
  end

  def create
    @boat = Boat.new(create_boat_params)
    @boat.user = current_user
    if @boat.save
      redirect_to @boat
    else
      render :new
    end
  end

  def show
    @boat = Boat.find(params['id'])
    @user = current_user
    @boats = @user.boats
    @booking = Booking.new
  end

  def update
    @boat = Boat.find(params['id'])
    # raise
    if params["boat"].nil?
      # removes bug if the update button is selected without any ingredients
      return render :index
    end
    @boat.update(boat_params)

    redirect_to user_boats_path
  end

  def destroy
    @boat = Boat.find(params['id'])
    @boat.destroy
    redirect_to user_boats_path
  end

  private

  def boat_params
    params.require(:boat).permit(:name, :address, :description, :photos, photos: [])
  end

  def create_boat_params
    params.require(:boat).permit(
      :name, :description, :price_per_day, :photos, photos: [], address_attributes: %i[id street_address city country]
    )
  end
end
