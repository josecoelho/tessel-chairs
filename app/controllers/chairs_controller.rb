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

  def unbook
    @chair = Chair.find(params[:id])

    if @chair.user_id != current_user.id
      flash[:error] = "Chair #{chair.name} is not yours! What are you trying to do?"
    else
      flash[:success] = "Chair #{chair.name} is available now!"
      @chair.unbook!
    end

    redirect_to root_url
  end

  def book
    @chair = Chair.find(params[:id])

    begin
      @chair.book_to current_user
    rescue Exception => e
      flash[:error] = e.message
    end


    redirect_to root_url
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
