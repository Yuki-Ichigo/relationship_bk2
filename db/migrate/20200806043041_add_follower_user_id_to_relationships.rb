class AddFollowerUserIdToRelationships < ActiveRecord::Migration[5.2]
  def change
    add_column :relationships, :follower_user_id, :integer
  end
end
