class Classification < ApplicationRecord
  include Visibility

  belongs_to :app
  belongs_to :moderator, class_name: 'User'
  has_many :app_accesses
  has_many :levels

  validates_presence_of :app, :moderator, :name, :description
end