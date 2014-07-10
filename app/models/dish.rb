class Dish < ActiveRecord::Base
  belongs_to :meal
  belongs_to :usermeal, foreign_key: :claimer_id
  has_many :comments, as: :commentable, dependent: :destroy


  VALID_URL_REGEX = /\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z/ix
  validates :thumb_url, :recipe_url, format: {with: VALID_URL_REGEX, message: "is not properly formed"}
end
