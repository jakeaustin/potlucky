class CreateDishes < ActiveRecord::Migration
  def change
    create_table :dishes do |t|
      t.text :name, :thumb_url, :recipe_url, null: false
      t.boolean :can_be_claimed, default: true
      t.references :meal, null: false
      t.integer :claimer_id, references: :usermeals, null: false
    end
  end
end
