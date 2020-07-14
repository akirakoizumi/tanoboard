# create_table "group_users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
#   t.bigint "group_id", null: false
#   t.bigint "user_id", null: false
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.index ["group_id", "user_id"], name: "index_group_users_on_group_id_and_user_id", unique: true
#   t.index ["user_id"], name: "index_group_users_on_user_id"
# end

GroupUser.seed do |s|
  s.id = 1
  s.group_id = 10 # 長崎店
  s.user_id = 11 # 濱川
end
