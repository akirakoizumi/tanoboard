class Task < ApplicationRecord
  belongs_to :user
  belongs_to :group

  has_many :reactions, dependent: :destroy

  validates :content, presence: true

  scope :recent, -> { order(created_at: :desc) }
end
