require 'rails_helper'

RSpec.describe type: :request do
  describe "sessions_controller" do
    it "ログイン画面にアクセスできる" do
      get login_path
      expect(response).to have_http_status(:success)
    end
  end
end
