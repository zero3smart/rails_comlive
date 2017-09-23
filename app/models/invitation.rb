class Invitation < ApplicationRecord
  belongs_to :app
  belongs_to :sender, class_name: "User"

  before_create :assign_token

  validates_presence_of :app_id, :sender_id, :recipient_email
  validates_uniqueness_of :recipient_email, scope: :app_id, message: " is already a member of this app"
  validates_format_of :recipient_email, :with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/
  private

  def assign_token
   loop do
     self.token = SecureRandom.base64.tr('+/=', 'Qrt')
     break unless Invitation.exists?(token: token)
   end
  end
end
