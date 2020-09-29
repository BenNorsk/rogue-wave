class User::BoatsController < ApplicationController
  

  def index
    @user = current_user
  end
end
