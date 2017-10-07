class Member < ApplicationRecord
  belongs_to :user
  belongs_to :app

  validates_presence_of :user, :app
end