# spec/features/posts_show_spec.rb
require 'rails_helper'

RSpec.describe 'PostShow', type: :feature do
  before do
    @user = User.create!(name: 'User', email: 'user@example.com')
    @post = @user.posts.create!(title: 'Sample Post', text: 'This is a sample post')
  end

  before { visit post_path(@post) }

  it 'shows the post title' do
    expect(page).to have_content(@post.title)
  end

  it 'shows the post author' do
    expect(page).to have_content(@post.author.name)
  end

  it 'shows the number of comments' do
    expect(page).to have_content("Comments: #{@post.comments.count}")
  end

  it 'shows the number of likes' do
    expect(page).to have_content("Likes: #{@post.likes_counter}")
  end

  it 'shows the post body' do
    expect(page).to have_content(@post.text)
  end

  it 'shows the username of each commentor' do
    @post.comments.each do |comment|
      expect(page).to have_content(comment.user.name)
    end
  end

  it 'shows the comment each commentor left' do
    @post.comments.each do |comment|
      expect(page).to have_content(comment.text)
    end
  end
end
