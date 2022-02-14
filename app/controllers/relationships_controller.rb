class RelationshipsController < ApplicationController
  respond_to? :js
  def create
    @user = User.find(params[:relationship][:followed_id])
    unless current_user == @user
      current_user.follow!(@user)
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    unless current_user == @user
      current_user.unfollow!(@user)
      render :create
    end
  end

end
