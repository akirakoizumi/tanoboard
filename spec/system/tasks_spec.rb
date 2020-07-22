# frozen_string_literal: true

require 'rails_helper'

describe 'task system spec', type: :system do
  def login(id)
    visit login_path
    login_user = User.find(id)
    fill_in 'IDまたはメールアドレス', with: login_user.id
    fill_in 'パスワード', with: 'password'
    click_button('ログインする')
  end
  context '管理ユーザーでログインした時' do
    before do
      login(1)
      visit group_path(1)
    end

    it '自分が作っていないタスクは削除ボタンが表示されない' do
      within(".card-body.task-81") do
        expect(page).not_to have_link '削除'
      end
    end

    it 'タスクを投稿できる' do
      fill_in 'タスク内容', with: 'テスト用タスク001'
      click_button('登録する')
      expect(page.body).to include 'テスト用タスク001'
    end

    context 'タスクを投稿した後' do
      before do
        fill_in 'タスク内容', with: 'テスト用タスク002'
        click_button('登録する')
      end

      it '詳細ページにアクセスできる' do
        click_link 'テスト用タスク002'
        expect(current_path).to eq task_path(Task.find_by(content: 'テスト用タスク002'))
      end

      it '一覧のタスクに削除が表示される' do
        within(".card-body.task-#{Task.find_by(content: 'テスト用タスク002').id}") do
          expect(page).to have_link '削除'
        end
      end
    end
  end
end
