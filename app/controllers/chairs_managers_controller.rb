class ChairsManagersController < ApplicationController
  skip_before_action :require_login, only: [:register]


  def index
    @chairs_managers = ChairsManager.all
  end

  def new
    @chairs_manager = ChairsManager.new
  end

  def create
    @chairs_manager = ChairsManager.new(chairs_manager_params)
    if @chairs_manager.save
      redirect_to chairs_managers_url
    else
      # # This line overrides the default rendering behavior, which
      # # would have been to render the "create" view.
      render "new"
    end

  end

  def register
    register_params = params.permit(:name, :url, :chairs)

    ChairsManager.register register_params[:name], register_params[:url], register_params[:chairs].split(',')

    render inline: "Success! You are registed"
  end

  def edit
    @chairs_manager = ChairsManager.find(params[:id])
  end

  def update
    @chairs_manager = ChairsManager.find(params[:id])

    if @chairs_manager.update_attributes(chairs_manager_params)
      redirect_to chairs_managers_url
    else
      render "edit"
    end
  end

  def destroy
    @chairs_manager = ChairsManager.find(params[:id])

    @chairs_manager.destroy
    redirect_to chairs_managers_url
  end

  private
    def chairs_manager_params
      params.require(:chairs_manager).permit(:name, :url, :active)
    end


end
