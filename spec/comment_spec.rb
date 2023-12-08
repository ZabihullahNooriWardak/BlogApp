require 'rails_helper'

RSpec.describe Comment, type: :model do
  let!(:user) { User.create!(name: 'Test User', posts_counter: 0) }
  let!(:post) { Post.create!(title: 'Test Post', author: user, comments_counter: 0, likes_counter: 0) }

  it 'increments the comments counter when created' do
    expect { Comment.create(text: 'Test Comment', user: user, post: post) }.to change {
      post.reload.comments_counter
    }.by(1)
  end

  it 'decrements the comments counter when destroyed' do
    comment = Comment.create(text: 'Test Comment', user: user, post: post)
    expect { comment.destroy }.to change { post.reload.comments_counter }.by(-1)
  end

  describe '#update_comments_counter' do
    it 'updates the comments counter of the post' do
      comment = Comment.create(text: 'Test Comment', user: user, post: post)
      expect { comment.destroy }.to change { post.reload.comments_counter }.by(-1)
    end
  end
end
