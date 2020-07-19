require 'rails_helper'

RSpec.describe type: :request do
  describe "sessions_controller" do
    it "ログイン画面にアクセスできる" do
      get login_path
      expect(response).to have_http_status(:success)
    end

    context '"ログインを記憶する"にチェックした時' do
      it "ログイン記憶のcookieが正しく保存される" do
        post login_path, params: { session: { id_or_email: '1', password: 'password', remember_me: '1' } }
        expect(BCrypt::Password.new(User.find(1).remember_digest).is_password?(response.cookies['remember_token'])).
          to be true
      end
    end

    context '"ログインを記憶する"のチェックを外した時' do
      it "ログイン記憶のcookieが保存されない" do
        post login_path, params: { session: { id_or_email: '1', password: 'password', remember_me: '0' } }
        expect(response.cookies['remember_token']).to be nil
      end
    end
  end
end
