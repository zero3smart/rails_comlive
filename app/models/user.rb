class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  #devise :invitable, :database_authenticatable, :registerable,
  #       :recoverable, :rememberable, :trackable, :validatable

  #before_create :assign_token

  #validates :token, uniqueness: true
  has_many :apps
  has_many :memberships
  has_many :brands, source: :member, source_type: "Brand", through: :memberships
  has_many :standards, source: :member, source_type: "Standard", through: :memberships
  has_many :members
  has_many :invited_apps, through: :members, source: :app

  private

  #def assign_token
  #  loop do
  #    self.token = SecureRandom.base64.tr('+/=', 'Qrt')
  #    break unless User.exists?(token: token)
  #  end
  #end

end