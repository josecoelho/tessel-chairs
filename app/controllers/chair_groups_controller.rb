class ChairGroupsController < ApplicationController
  skip_before_action :require_login, only: [:register]


  def index
    @chair_groups = ChairGroup.all
  end

  def new
    @chair_group = ChairGroup.new
  end

  def create
    @chair_group = ChairGroup.new(chair_group_params)
    if @chair_group.save
      redirect_to chair_groups_url
    else
      # # This line overrides the default rendering behavior, which
      # # would have been to render the "create" view.
      render "new"
    end

  end

  def register
    register_params = params.permit(:name, :url, :chairs)

    ChairGroup.register register_params[:name], register_params[:url], register_params[:chairs]

    render inline: "Success! You are registed"
  end

  def edit
    @chair_group = ChairGroup.find(params[:id])
  end

  def update
    @chair_group = ChairGroup.find(params[:id])

    if @chair_group.update_attributes(chair_group_params)
      redirect_to chair_groups_url
    else
      render "edit"
    end
  end

  def destroy
    @chair_group = ChairGroup.find(params[:id])

    @chair_group.destroy
    redirect_to chair_groups_url
  end

  private
    def chair_group_params
      params.require(:chair_group).permit(:name, :chair_ids)
    end


end
