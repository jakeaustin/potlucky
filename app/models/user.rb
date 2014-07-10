class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :invites, dependent: :destroy
  has_many :meals, through: :invites
  has_many :hosted_invites, -> { where role: 'host' }, class_name: Invite
  has_many :hosted_meals, through: :hosted_invites, dependent: :destroy, source: :meal

  has_many :guest_invites, -> { where role: 'guest', invite_status: 'attending' }, class_name: Invite
  has_many :guest_meals, through: :guest_invites, source: :meal
  has_many :invited_invites, -> { where role: 'guest', invite_status: 'pending' }, class_name: Invite
  has_many :invited_meals, through: :invited_invites, source: :meal
  has_many :declined_invites, -> { where role: 'guest', invite_status: 'decline' }, class_name: Invite
  has_many :declined_meals, through: :declined_invites, source: :meal



  def self.search(query)
    where("email like ?", "%#{query}%")
  end

end
