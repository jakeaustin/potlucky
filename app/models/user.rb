class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :user_meals, dependent: :destroy
  has_many :meals, through: :user_meals
  has_many :hosted_user_meals, -> { where role: 'host' }, class_name: UserMeal
  has_many :hosted_meals, through: :hosted_user_meals, dependent: :destroy, source: :meal

  has_many :guest_user_meals, -> { where role: 'guest', invite_status: 'attending' }, class_name: UserMeal
  has_many :guest_meals, through: :guest_user_meals, source: :user, source: :meal
  has_many :invited_user_meals, -> { where role: 'guest', invite_status: 'pending' }, class_name: UserMeal
  has_many :invited_meals, through: :invited_user_meals, source: :user, source: :meal

  def self.search(query)
    where("email like ?", "%#{query}%")
  end

end
