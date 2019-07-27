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
    @user_group = @map.user_groups.where(user_group_params).first_or_create
    authorize @user_group
    respond_to { |format| format.js } # <-- will render `app/views/user_groups/create.js.erb`
  end

  def user_group_params
    params.require(:user_group).permit(:user_id)
  end
end
