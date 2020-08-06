class RelationshipsController < ApplicationController

	def create
		@user = User.find(params[:user_id])
		@relationship = Relationship.new
		@relationship.follow_user_id = current_user.id
		@relationship.follower_user_id = @user.id
		@relationship.save
		redirect_to request.referer
	end

	def destroy
		@user = User.find(params[:user_id])
		@relationship = current_user.active_relationships.find_by(follower_user_id: params[:user_id])
		@relationship.destroy
		redirect_to request.referer
	end

end
