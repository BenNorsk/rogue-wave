class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home playground]

  def home
  end

  def playground
  end

  def image_carousel
  end
end
