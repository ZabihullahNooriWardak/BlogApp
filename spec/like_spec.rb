require 'rails_helper'

RSpec.describe Like, type: :model do
  let!(:user) { User.create!(name: 'Test User', posts_counter: 0) }
  let!(:post) { Post.create!(title: 'Test Post', author: user, comments_counter: 0, likes_counter: 0) }

  it 'increments the likes counter when created' do
    expect { Like.create(user: user, post: post) }.to change { post.reload.likes_counter }.by(1)
  end

  it 'decrements the likes counter when destroyed' do
    like = Like.create(user: user, post: post)
    expect { like.destroy }.to change { post.reload.likes_counter }.by(-1)
  end

  describe '#update_likes_counter' do
    it 'updates the likes counter of the post' do
      like = Like.create(user: user, post: post)
      expect { like.destroy }.to change { post.reload.likes_counter }.by(-1)
    end
  end
end
