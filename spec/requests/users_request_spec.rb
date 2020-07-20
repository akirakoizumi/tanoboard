require 'rails_helper'

RSpec.describe type: :request do
  describe "users_controller" do
    def login(id)
      post login_path, params: { session: { id_or_email: id, password: 'password', remember_me: '1' } }
    end

    context '管理ユーザーでログインした時' do
      before do
        login(1)
      end

      it "IDが表示される" do
        within('td') do
          expect(page).to have_content '1'
        end
      end

      it "名前が表示される" do
        within('td') do
          expect(page).to have_content User.find(1).name
        end
      end

      it "emailが表示される" do
        within('td') do
          expect(page).to have_content User.find(1).email
        end
      end

      it "管理権あり表示される" do
        within('td') do
          expect(page).to have_content 'あり'
        end
      end
    end

    context 'サブユーザーでログインした時' do
      before do
        login(2)
      end

      it "IDが表示される" do
        within('td') do
          expect(page).to have_content '1'
        end
      end

      it "名前が表示される" do
        within('td') do
          expect(page).to have_content User.find(1).name
        end
      end

      it "emailが表示される" do
        within('td') do
          expect(page).to have_content User.find(1).email
        end
      end

      it "管理権なしと表示される" do
        within('td') do
          expect(page).to have_content 'なし'
        end
      end
    end
  end
end
