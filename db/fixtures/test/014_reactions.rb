# create_table "reactions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
#   t.integer "user_id"
#   t.integer "task_id"
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.index ["task_id", "user_id"], name: "index_reactions_on_task_id_and_user_id", unique: true
#   t.index ["user_id"], name: "index_reactions_on_user_id"
# end

50.times do |num|
  Reaction.seed do |s|
    s.id = num # 00~49
    s.user_id = 1 # 濱川
    s.task_id = num
  end
end

# 50.times do |num|
#  Reaction.seed do |s|
#    s.id = num + 50 # 50~99
#    s.user_id = 2 # 岩木
#    s.task_id = num
#  end
# end
#
# 10.upto(49) do |num|
#  Reaction.seed do |s|
#    s.id = num + 100 # 100~139
#    s.user_id = 3 # 小野
#    s.task_id = num
#  end
# end
#
# 30.upto(49) do |num|
#  Reaction.seed do |s|
#    s.id = num + 140 # 140~169
#    s.user_id = 4 # 若林
#    s.task_id = num
#  end
# end
