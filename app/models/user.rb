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

  after_create :create_app

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
      user.provider     = auth.provider
      user.uid          = auth.uid
      user.email        = auth.info.email
      user.first_name   = auth.info.first_name
      user.last_name    = auth.info.last_name
      user.oauth_token  = auth.credentials.token
      user.save!
    end
  end

  def default_app
    App.where(user_id: self.id, default: true).first
  end

  private

  def create_app
    self.apps.create(name: Faker::App.name, description: "App description", default: true)
  end

  #def assign_token
  #  loop do
  #    self.token = SecureRandom.base64.tr('+/=', 'Qrt')
  #    break unless User.exists?(token: token)
  #  end
  #end

end