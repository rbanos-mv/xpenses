class GroupsController < ApplicationController
  def create
    if @group.save
      flash[:notice] = 'Category saved successfully'
    else
      flash[:alert] = 'Category not saved'
    end
    redirect_to groups_path
  end

  def index
    @groups = current_user.groups
  end

  def new
    @icons = Group.icon_list
  end

  def show
    # implement
  end

  private

  def group_params
    params.require(:group).merge({ user_id: current_user.id })
      .permit(:user_id, :name, :icon)
  end
end
