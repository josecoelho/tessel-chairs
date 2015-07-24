class ChairsManagersController < ApplicationController

  def index
    @chair_managers = ChairsManager.all
  end

  def new
    @chair_manager = ChairsManager.new
  end

  def create
    @chair_manager = ChairsManager.new(chair_manager_params)
    if @chair_manager.save
      redirect_to chair_managers_managers_url
    else
      # # This line overrides the default rendering behavior, which
      # # would have been to render the "create" view.
      render "new"
    end

  end

  def unbook
    @chair_manager = ChairsManager.find(params[:id])

    if @chair_manager.user_id != current_user.id
      flash[:error] = "ChairsManager #{chair_manager.name} is not yours! What are you trying to do?"
    else
      flash[:success] = "ChairsManager #{chair_manager.name} is available now!"
      @chair_manager.unbook!
    end

    redirect_to root_url
  end

  def book
    @chair_manager = ChairsManager.find(params[:id])

    begin
      @chair_manager.book_to current_user
    rescue Exception => e
      flash[:error] = e.message
    end


    redirect_to root_url
  end

  def edit
    @chair_manager = ChairsManager.find(params[:id])
  end

  def update
    @chair_manager = ChairsManager.find(params[:id])

    if @chair_manager.update_attributes(chair_manager_params)
      redirect_to chair_managers_managers_url
    else
      render "edit"
    end
  end

  def destroy
    @chair_manager = ChairsManager.find(params[:id])

    @chair_manager.destroy
    redirect_to chair_managers_managers_url
  end

  private
    def chair_manager_params
      params.require(:chair_manager).permit(:name, :url, :active)
    end


end
