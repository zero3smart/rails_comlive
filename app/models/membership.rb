class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :member, :polymorphic => true

  validates_presence_of :user, :member
end