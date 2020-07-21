# frozen_string_literal: true

require 'rails_helper'

describe 'groups system spec', type: :system do
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

    describe 'グループ詳細画面' do
      before do
        visit group_path(1)
      end

      it 'グループ名が表示される' do
        User.find(1).groups.each do |group|
          expect(page.body).to include group.name
        end
      end

      it 'グループ説明が表示される' do
        User.find(1).groups.each do |group|
          expect(page.body).to include group.description
        end
      end

      it 'サブメンバー作成画面にアクセスできる' do
        click_link('グループメンバーを作成する')
        expect(current_path).to eq new_sub_user_path(1)
      end

      it 'グループ情報編集画面にアクセスできる' do
        click_link('グループ情報編集')
        expect(current_path).to eq edit_group_path(1)
      end
    end
  end

  context 'サブユーザーでログインした時' do
    before do
      login(2)
    end

    it 'グループ作成画面にアクセスできない' do
      visit new_group_path
      expect(current_path).not_to eq new_group_path
    end
  end
end
