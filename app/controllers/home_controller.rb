class HomeController < ApplicationController

  def index
    @chairs = Chair.all
  end

end
