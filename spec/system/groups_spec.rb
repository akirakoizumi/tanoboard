# frozen_string_literal: true

require 'rails_helper'

describe 'session system spec', type: :system do
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
    end

    it 'グループ作成画面から作成できる' do
      visit new_group_path
      fill_in '名前', with: 'テスト用グループ'
      fill_in 'グループ説明', with: 'テスト用説明文'
      click_button('登録する')
      expect(current_path).to eq group_path(Group.find_by(name: 'テスト用グループ'))
    end
  end
end
