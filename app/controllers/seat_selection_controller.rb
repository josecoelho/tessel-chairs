class SeatSelectionController < ApplicationController

  def index

    @available_chairs = Chair.available

    @matrix = {}

    ChairGroup.all.each do |group|
      @matrix[group.id] = {} if @matrix[group.id].nil?
      group.chairs.each do |chair|
        @matrix[group.id][chair.id] = chair
      end
    end

    @current_user_id = current_user.id
  end

end
