class GroupUser < ApplicationRecord
  belongs_to :group
  belongs_to :user
  accepts_nested_attributes_for :group_users
end
