class RenameUserMealsToInvites < ActiveRecord::Migration
  def self.up
    rename_table :usermeals, :invites
  end
  def self.down
    rename_table :invites, :usermeals
  end
end
