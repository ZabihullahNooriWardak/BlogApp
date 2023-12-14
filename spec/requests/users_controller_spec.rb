require 'rails_helper'

RSpec.describe 'UsersController', type: :request do
  let!(:user) { User.create!(name: 'Test User') }

  describe 'GET /index' do
    it 'returns a successful response' do
      get users_path
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      get users_path
      expect(response).to render_template(:index)
    end

    it "includes the user's name in the response body" do
      get users_path
      expect(response.body).to include(user.name)
    end
  end

  describe 'GET /show' do
    it 'returns a successful response' do
      get user_path(user)
      expect(response).to have_http_status(:success)
    end

    it 'renders the show template' do
      get user_path(user)
      expect(response).to render_template(:show)
    end

    it "includes the user's name in the response body" do
      get user_path(user)
      expect(response.body).to include(user.name)
    end
  end
end
