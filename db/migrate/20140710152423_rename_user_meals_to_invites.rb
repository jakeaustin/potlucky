class RenameUserMealsToInvites < ActiveRecord::Migration
  def self.up
    rename_table :user_meals, :invites
  end
  def self.down
    rename_table :invites, :user_meals
  end
end
