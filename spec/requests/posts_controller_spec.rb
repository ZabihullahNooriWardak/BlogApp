require 'rails_helper'

RSpec.describe 'PostsController', type: :request do
  let!(:user) { User.create!(name: 'Test User') }
  let!(:post) { Post.create!(title: 'Test Post', author: user, comments_counter: 0, likes_counter: 0) }

  describe 'GET /index' do
    it 'returns a successful response' do
      get user_posts_path(user)
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      get user_posts_path(user)
      expect(response).to render_template(:index)
    end

    it "includes the post's title in the response body" do
      get user_posts_path(user)
      expect(response.body).to include(post.title)
    end
  end

  describe 'GET /show' do
    it 'returns a successful response' do
      get user_post_path(post)
      expect(response).to have_http_status(:success)
    end

    it 'renders the show template' do
      get user_post_path(post)
      expect(response).to render_template(:show)
    end

    it "includes the post's title in the response body" do
      get user_post_path(post)
      expect(response.body).to include(post.title)
    end
  end
end
