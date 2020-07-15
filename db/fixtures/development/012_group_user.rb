# create_table "group_users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
#   t.bigint "group_id", null: false
#   t.bigint "user_id", null: false
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.index ["group_id", "user_id"], name: "index_group_users_on_group_id_and_user_id", unique: true
#   t.index ["user_id"], name: "index_group_users_on_user_id"
# end

NAGASAKI_BRANCH_ID = 1
SAGA_BRANCH_ID = 2

GroupUser.seed do |s|
  s.id = 1
  s.group_id = NAGASAKI_BRANCH_ID # 長崎店
  s.user_id = 1 # 濱川
end

GroupUser.seed do |s|
  s.id = 2
  s.group_id = NAGASAKI_BRANCH_ID # 長崎店
  s.user_id = 2 # 岩木
end

GroupUser.seed do |s|
  s.id = 3
  s.group_id = NAGASAKI_BRANCH_ID # 長崎店
  s.user_id = 3 # 小野
end

GroupUser.seed do |s|
  s.id = 4
  s.group_id = NAGASAKI_BRANCH_ID # 長崎店
  s.user_id = 4 # 若林
end

GroupUser.seed do |s|
  s.id = 5
  s.group_id = SAGA_BRANCH_ID # 長崎店
  s.user_id = 11 # 北原
end

GroupUser.seed do |s|
  s.id = 6
  s.group_id = SAGA_BRANCH_ID # 長崎店
  s.user_id = 12 # 青山
end
