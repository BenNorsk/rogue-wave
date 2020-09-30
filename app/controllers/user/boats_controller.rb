class User::BoatsController < ApplicationController


  def index
    if !params["boat_id"].nil?
      @user = current_user
      @selected_boat = Boat.find(params["boat_id"])
    else
      @user = current_user
    end
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

    redirect_to user_boats_path
  end

  def destroy
    @boat = Boat.find(params['id'])
    @boat.destroy
    redirect_to user_boats_path
  end

  private

  def boat_params
    params.require(:boat).permit(:name, :description, :photos, photos: [])
  end
end
