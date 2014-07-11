class Meal < ActiveRecord::Base
  has_many :dishes, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :invites, dependent: :destroy
  has_many :users, through: :invites
  has_many :guest_invites, -> { where invite_status: ['attending', 'pending', 'decline'] }, class_name: Invite
  has_many :guest_users, through: :guest_invites, source: :user
  has_many :attending_invites, -> { where invite_status: 'attending', role:
  'guest' }, class_name: Invite
  has_many :attending_guests, through: :attending_invites, source: :user
  has_one :host_invite, -> { where role: 'host' }, class_name: Invite
  has_one :host, through: :host_invite, source: :user

end
