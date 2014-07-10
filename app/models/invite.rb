class Invite < ActiveRecord::Base
  belongs_to :user
  belongs_to :meal
  has_many :dishes


end
