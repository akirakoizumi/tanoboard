require 'rails_helper'

RSpec.describe type: :request do
  describe "rspecの起動確認" do
    xit "rspecが起動する" do
      get login_path
      expect(response).to have_http_status(:success)
    end
  end
end
