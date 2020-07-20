# frozen_string_literal: true

require 'rails_helper'

describe 'header system spec', type: :system do
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

    it 'ユーザー詳細のリンクが表示され移動できる' do
      click_link 'ユーザー詳細'
      expect(current_path).to eq user_path(1)
    end

    it 'グループ作成のリンクが表示され移動できる' do
      click_link 'グループ作成'
      expect(current_path).to eq new_group_path
    end

    it 'グループページへのリンクが表示され移動できる' do
      click_link 'グループページへ'
      expect(current_path).to eq group_path(1)
    end

    it 'ログアウトのリンクが表示され移動できる' do
      within('.sticky-top') do
        click_link 'ログアウト'
        expect(current_path).to eq root_path
      end
    end
  end

  context 'サブユーザーでログインした時' do
    before do
      login(2)
    end

    it 'ユーザー詳細のリンクが表示され移動できる' do
      click_link 'ユーザー詳細'
      expect(current_path).to eq user_path(2)
    end

    it 'グループページへのリンクが表示され移動できる' do
      click_link 'グループページへ'
      expect(current_path).to eq group_path(1)
    end

    it 'グループ作成のリンクが表示されない' do
      expect(page).not_to have_link 'グループ作成'
    end

    it 'ログアウトのリンクが表示され移動できる' do
      within('.sticky-top') do
        click_link 'ログアウト'
        expect(current_path).to eq root_path
      end
    end
  end

  context 'ログインしてない時' do
    before do
      visit root_path
    end

    it '管理ユーザー登録のリンクが表示され移動できる' do
      within('.sticky-top') do
        click_link '管理ユーザー登録'
        expect(current_path).to eq signup_path
      end
    end

    it 'ログインのリンクが表示され移動できる' do
      within('.sticky-top') do
        click_link 'ログイン'
        expect(current_path).to eq login_path
      end
    end
  end
end
