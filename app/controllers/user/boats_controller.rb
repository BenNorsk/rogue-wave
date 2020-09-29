class User::BoatsController < ApplicationController


  def index
    @user = current_user
  end

  def show
    @boat = Boat.find(params['id'])
    @user = current_user
    @boats = @user.boats
  end

  def update
    @boat = Boat.find(params['id'])
    # raise
    if params["boat"].nil?
      # removes bug if the update button is selected without any ingredients
      return render :index
    end
    @boat.update(boat_params)

    render :show
  end

  private

  def boat_params
    params.require(:boat).permit(:name, :description, :photos, photos: [])
  end
end
