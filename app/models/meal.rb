class Meal < ActiveRecord::Base
  has_many :user_meals, dependent: :destroy
  has_many :users, through: :user_meals

end
