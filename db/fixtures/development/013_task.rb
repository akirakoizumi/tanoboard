# create_table "tasks", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
#   t.text "content"
#   t.bigint "user_id"
#   t.bigint "group_id", null: false
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.index ["group_id", "created_at"], name: "index_tasks_on_group_id_and_created_at"
#   t.index ["user_id"], name: "index_tasks_on_user_id"
# end

50.times do |num|
  Task.seed do |s|
    s.id = num # 00~49
    s.content = "濱川店長からの連絡 No.#{num} コンテンツの中身"
    s.user_id = 1 # 濱川
    s.group_id = 1 # 長崎店
  end
end

Task.seed do |s|
  s.id = 50
  s.content = "濱川店長へレモンの買い出しをお願いします"
  s.user_id = 2 # 岩木
  s.group_id = 1 # 長崎店
end

30.times do |num|
  Task.seed do |s|
    s.id = num # 50~80
    s.content = "佐賀店の連絡 No.#{num} 連絡内容"
    s.user_id = 11 # 北原
    s.group_id = 2 # 佐賀店
  end
end
