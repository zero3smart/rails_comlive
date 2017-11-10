module Uuideable
  extend ActiveSupport::Concern

  included do
    before_create :set_uuid
  end

  private

  def set_uuid
    loop do
      self.uuid = rand(10 ** 10).to_s.rjust(10,'0')
      break unless self.class.exists?(uuid: uuid)
    end
  end
end