# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# create_table "groups", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
# t.string "name", null: false
# t.text "description"
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.index ["name"], name: "index_groups_on_name", unique: true
# end
Group.create!(
  name: '長崎店',
  description: '明るく楽しい職場を作ろう！'
)

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

User.create!(
  name: '濱川',
  email: 'hamakawa@example.com',
  admin: true,
  password: 'password',
  password_confirmation: 'password'
)
