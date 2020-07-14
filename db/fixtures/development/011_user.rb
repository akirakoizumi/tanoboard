# create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
#   t.string "name", null: false
#   t.string "email"
#   t.string "password_digest", null: false
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.boolean "admin", default: false, null: false
#   t.string "remember_digest"
#   t.integer "default_group_id"
#   t.index ["email"], name: "index_users_on_email", unique: true
# end

User.seed do |s|
  s.id = 11
  s.name = '濱川'
  s.email = 'hamakawa@example.com'
  s.admin = true
  s.password = 'password'
  s.password_confirmation = 'password'
  # s.group = Group.find_by(name: '長崎店')
end
