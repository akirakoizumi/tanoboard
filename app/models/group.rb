class Group < ApplicationRecord
  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users
  validates :name, presence: true, uniqueness: true, length: { maximum: 50 }
end
