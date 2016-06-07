class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_create :assign_token

  validates :token, uniqueness: true
  has_many :apps


  private

  def assign_token
    loop do
      self.token = SecureRandom.base64.tr('+/=', 'Qrt')
      break unless User.exists?(token: token)
    end
  end

end
