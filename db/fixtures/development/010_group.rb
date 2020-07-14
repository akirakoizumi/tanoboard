# create_table "groups", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
#   t.string "name", null: false
#   t.text "description"
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.index ["name"], name: "index_groups_on_name", unique: true
# end

Group.seed do |s|
  s.id = 10
  s.name = '長崎店'
  s.description = '明るく楽しい職場を作ろう！'
end
