class UserGroupsController < ApplicationController

  def show
    @user_group = UserGroup.all
  end

end
