class Create < ActiveRecord::Migration
  def change
    create_table :user_meals do |t|
      t.references :user, :meal, null: false
      t.text :role
      t.text :invite_status
    end
  end
end
