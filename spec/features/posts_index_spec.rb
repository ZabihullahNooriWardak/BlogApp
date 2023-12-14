# spec/features/posts_index_spec.rb
require 'rails_helper'

RSpec.describe 'UserPostsIndex', type: :feature do
  before do
    @user = User.create!(name: 'User', email: 'user@example.com', bio: 'This is a user bio.', photo: 'https://vivolabs.es/wp-content/uploads/2022/03/perfil-hombre-vivo.png')

    10.times { |i| @user.posts.create!(title: "Post #{i + 1}", text: "This is post #{i + 1}") }

    visit user_posts_path(@user)
  end

  it 'shows the user\'s profile picture' do
    expect(page).to have_css('img[alt="User Image"]')
  end

  it 'shows the user\'s username' do
    expect(page).to have_content(@user.name)
  end

  it 'shows the number of posts the user has written' do
    expect(page).to have_content("Number of posts: #{@user.posts.count}")
  end

  it 'shows posts of a user' do
    @user.posts.first(5).each do |post|
      expect(page).to have_content(post.title)
      expect(page).to have_content(post.text[0..20])
    end
  end

  it 'shows the first comments on a post' do
    @user.posts.each do |post|
      post.comments.first(3).each do |comment|
        expect(page).to have_content(comment.text)
      end
    end
  end

  it 'shows how many comments a post has' do
    @user.posts.each do |post|
      expect(page).to have_content("Number of comments: #{post.comments.size}")
    end
  end

  it 'shows how many likes a post has' do
    @user.posts.each do |post|
      expect(page).to have_content("Number of likes: #{post.likes_counter}")
    end
  end

  it 'shows a section for pagination' do
    expect(page).to have_selector('.pagination')
  end

  it 'redirects to the post show page on click' do
    first_post = @user.posts.first
    click_on first_post.title
    expect(current_path).to eq(post_path(first_post))
  end
end
