require 'rails_helper'

RSpec.describe "Groups", type: :request do
  def login(id)
    post login_path, params: { session: { id_or_email: id, password: 'password', remember_me: '1' } }
  end

  context '管理ユーザーでログインした時' do
    before do
      login(1)
      get group_path(1)
    end

    it 'グループを削除できる' do
      expect { delete group_path(1) }.to change(Group, :count).by(-1)
    end
  end
end
