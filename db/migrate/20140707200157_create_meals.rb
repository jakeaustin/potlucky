class CreateMeals < ActiveRecord::Migration
  def change
    create_table :meals do |t|
      t.text :title, :location, null: false
      t.datetime :hosted_at

    end
  end
end
