class SeatSelectionController < ApplicationController

  def index
    @chairs = Chair.all

    @matrix = {}

    (1..10).each do |line|
      @matrix[line] = {} if @matrix[line].nil?
      ["A","B","C","D","E","F","G","H","I","J","K","L"].each do |seat|
        @matrix[line][seat] = "#{line}#{seat}"
      end
    end

  end

end
