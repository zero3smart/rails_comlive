class User < ApplicationRecord
  has_many :memberships
  has_many :apps, source: :member, source_type: "App", through: :memberships
  has_many :brands, source: :member, source_type: "Brand", through: :memberships
  has_many :standards, source: :member, source_type: "Standard", through: :memberships

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
      user.provider      = auth.provider
      user.uid           = auth.uid
      user.email         = auth.info.email
      user.first_name    = auth.info.first_name
      user.last_name     = auth.info.last_name
      user.access_token  = auth.credentials.id_token
      user.refresh_token = auth.credentials.refresh_token
      user.expires_at    = Time.now + 36000.seconds
      user.save!
    end
  end

  def accept_invite(token)
    invitation = Invitation.find_by(token: token, accepted: false)
    return if invitation.nil?
    self.apps << invitation.app
    memberships.find_by(member_type: "App", member_id: invitation.app.id).update(default: true)
    invitation.update(accepted: true)
    return invitation
  end

  def default_app
    memberships.find_by(member_type: "App", default: true).member
  end

  def create_default_app
    app = apps.create(name: "Default App", description: "This is your default app")
    memberships.find_by(member_type: "App", member_id: app.id).update(owner: true, default: true)
    return app
  end

  def name
    return email.split("@").first if first_name.nil? || last_name.nil?
    [first_name, last_name].join(" ")
  end

  def fresh_token
    refresh! if token_expired?
    access_token
  end

  private

  def refresh!
    data = TokenRefresher.new(refresh_token)
    update_attributes(access_token: data['id_token'], expires_at: Time.now + (data['expires_in'].to_i).seconds)
  end

  def token_expired?
    expires_at < Time.now
  end
end