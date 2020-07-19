# frozen_string_literal: true

require 'rails_helper'

describe 'session system spec', type: :system do
  before do
    visit login_path
  end

  context '正しく入力した時' do
    it 'ユーザーがログインできる' do
      login_user = User.find(1)
      fill_in 'IDまたはメールアドレス', with: login_user.email
      fill_in 'パスワード', with: 'password'
      click_button('ログインする')
      expect(current_path).to eq user_path(login_user)
    end
  end

  context '誤った入力をした時' do
    it 'ユーザーがログインできない' do
      login_user = User.find(1)
      fill_in 'IDまたはメールアドレス', with: login_user.email
      fill_in 'パスワード', with: 'WRONG_password'
      click_button('ログインする')
      expect(current_path).not_to eq user_path(login_user)
    end
  end
end
