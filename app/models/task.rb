class Task < ApplicationRecord
  belongs_to :user
  belongs_to :group

  has_many :reaction, dependent: :destroy

  validates :content, presence: true

  scope :recent, -> { order(created_at: :desc) }

  def creator
    User.find(user_id)
  end

  def reacted_by?(user)
    reaction.where(user_id: user.id).exists?
  end

  def all_reaction_user
    User.find(Reaction.where(task_id: id).pluck('user_id'))
  end
end
