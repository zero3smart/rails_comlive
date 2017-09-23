class Ownership < ApplicationRecord
  belongs_to :parent, :polymorphic => true
  belongs_to :child, :polymorphic => true

  validates_uniqueness_of :child_id, scope: :parent_type
  validates_presence_of :parent, :child
  # validate :official_can_own
  # validate :offical_cannot_be_owned
  #
  # private
  #
  # def official_can_own
  #   if self.parent && !self.parent.official
  #     errors.add(:parent, " #{self.parent_type.downcase} must be the official #{self.parent_type.downcase}")
  #   end
  # end
  #
  # def offical_cannot_be_owned
  #   if self.child && self.child.official
  #     errors.add(:child, " #{self.parent_type.downcase} is official and cannot be owned")
  #   end
  # end
end
