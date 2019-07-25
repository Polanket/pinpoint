class UserGroupsController < ApplicationController

  def show
    @user_group = UserGroup.all
  end

  def new
    @map = Map.find(params[:map_id])
    @user_group = UserGroup.new
    authorize @user_group
  end

  def create
    @map = Map.find(params[:map_id])

    @user_group = UserGroup.new(user_group_params)
    @user_group.map = @map
    authorize @user_group
    if @user_group.save
      respond_to do |format|
        format.html { redirect_to map_path(@map) }
        format.js  # <-- will render `app/views/reviews/create.js.erb`
      end
    else
      respond_to do |format|
        format.html { render 'user_group/new' }
        format.js  # <-- idem
      end
    end
  end

  def user_group_params
    params.require(:user_group).permit(:user_id, :map_id)
  end
end
