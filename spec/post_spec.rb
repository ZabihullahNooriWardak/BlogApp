require 'rails_helper'

RSpec.describe Post, type: :model do
  it 'is not valid without a title' do
    post = Post.new(title: nil)
    expect(post).to_not be_valid
  end

  it 'is not valid with a title longer than 250 characters' do
    post = Post.new(title: 'a' * 251)
    expect(post).to_not be_valid
  end

  describe '#update_posts_counter' do
    let!(:user) { User.create!(name: 'Test User', posts_counter: 0) }
    let!(:post) { Post.create!(title: 'Test Post', author: user, comments_counter: 0, likes_counter: 0) }

    it 'increases the posts counter of the author when a post is destroyed' do
      expect { post.destroy }.to change { user.reload.posts_counter }.by(1)
    end
  end

  describe '#recent_comments' do
    let!(:user) { User.create!(name: 'Test User', posts_counter: 0) }
    let!(:post) { Post.create!(title: 'Test Post', author: user, comments_counter: 0, likes_counter: 0) }

    it 'returns the five most recent comments' do
      Comment.create!(text: 'Old Comment', user: user, post: post, created_at: 6.days.ago)
      recent_comments = 5.times.map do |i|
        Comment.create!(text: "Comment #{i}", user: user, post: post, created_at: i.days.ago)
      end

      expect(post.recent_comments).to match_array(recent_comments)
    end
  end
end
