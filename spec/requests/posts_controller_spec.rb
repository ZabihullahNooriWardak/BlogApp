# spec/requests/posts_controller_spec.rb

RSpec.describe 'PostsController', type: :request do
  describe 'GET /show' do
    let(:user) { User.create!(name: 'User', email: 'user@example.com') }
    let(:post) { Post.create!(title: 'Title', text: 'Text', author: user) }

    it 'returns a successful response' do
      get post_path(post)
      expect(response).to have_http_status(:success)
    end

    it 'renders the show template' do
      get post_path(post)
      expect(response).to render_template(:show)
    end

    it 'includes the post\'s title in the response body' do
      get post_path(post)
      expect(response.body).to include(post.title)
    end
  end
end
