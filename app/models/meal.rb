class Meal < ActiveRecord::Base
  has_many :dishes, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :user_meals, dependent: :destroy
  has_many :users, through: :user_meals
  has_many :guest_user_meals, -> { where invite_status: ['attending', 'pending', 'decline'] }, class_name: UserMeal
  has_many :guest_users, through: :guest_user_meals, source: :user
  has_many :attending_user_meals, -> { where invite_status: 'attending', role:
  'guest' }, class_name: UserMeal
  has_many :attending_guests, through: :attending_user_meals, source: :user
  has_one :host_user_meals, -> { where role: 'host' }, class_name: UserMeal
  has_one :host, through: :host_user_meals, source: :user
end
