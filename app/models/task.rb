class Task < ApplicationRecord
  belongs_to :user
  belongs_to :group

  has_many :reaction, dependent: :destroy

  validates :content, presence: true

  scope :recent, -> { order(created_at: :desc) }

  def reacted_by?(user)
    reaction.where(user_id: user.id).exists?
  end
end
