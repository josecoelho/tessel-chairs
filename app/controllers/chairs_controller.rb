class ChairsController < ApplicationController

  def index
    @chairs = Chair.all
  end

  def new
    @chair = Chair.new
  end

  def create
    @chair = Chair.new(chair_params)
    if @chair.save
      redirect_to chairs_url
    else
      # # This line overrides the default rendering behavior, which
      # # would have been to render the "create" view.
      render "new"
    end

  end

  def edit
    @chair = Chair.find(params[:id])
  end

  def update
    @chair = Chair.find(params[:id])

    if @chair.update_attributes(chair_params)
      redirect_to chairs_url
    else
      render "edit"
    end
  end

  def destroy
    @chair = Chair.find(params[:id])

    @chair.destroy
    redirect_to chairs_url
  end

  private
    def chair_params
      params.require(:chair).permit(:name, :user_id)
    end


end
