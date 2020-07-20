# frozen_string_literal: true

require 'rails_helper'

describe 'session user spec', type: :system do
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

    it '所属するグループ名が表示される' do
      User.find(1).groups.each do |group|
        expect(page).to have_link group.name
      end
    end

    it '所属するグループのユーザー名が表示される' do
      User.find(1).groups.each do |group|
        group.users.each do |user|
          expect(page).to have_link user.name
        end
      end
    end

    it 'ユーザー情報編集リンクが表示される' do
      expect(page).to have_link 'ユーザー情報編集'
    end

    it '名前変更が表示されない' do
      expect(page).not_to have_link '名前変更'
    end

    it 'パスワード変更リンクが表示される' do
      expect(page).to have_link 'パスワード変更'
    end

    it 'ログアウトリンクが表示される' do
      expect(page).to have_link 'ログアウト'
    end

    it '削除リンクが表示される' do
      expect(page).to have_link '削除'
    end
  end

  context 'サブユーザーでログインした時' do
    before do
      login(2)
    end

    it 'ユーザー情報編集リンクが表示されない' do
      expect(page).not_to have_link 'ユーザー情報編集'
    end

    it '名前変更が表示される' do
      expect(page).to have_link '名前変更'
    end

    it 'パスワード変更リンクが表示される' do
      expect(page).to have_link 'パスワード変更'
    end

    it 'ログアウトリンクが表示される' do
      expect(page).to have_link 'ログアウト'
    end

    it '削除リンクが表示される' do
      expect(page).to have_link '削除'
    end
  end
end
