# spec/features/user_show_spec.rb

require 'rails_helper'

RSpec.describe 'UserShow', type: :feature do
  before do
    @user = User.create!(name: 'User', email: 'user@example.com', bio: 'This is a user bio.', photo: 'https://vivolabs.es/wp-content/uploads/2022/03/perfil-hombre-vivo.png')

    @posts = 3.times.map do |i|
      @user.posts.create!(title: "Post #{i}", text: "Text #{i}", comments_counter: 0, likes_counter: 0)
    end
    visit user_path(@user)
  end

  it 'shows the user details and their posts' do
    expect(page).to have_content(@user.name)
    expect(page).to have_content("Number of posts: #{@user.posts.count}")
  end

  it 'shows the user\'s username' do
    expect(page).to have_content(@user.name)
  end

  it 'shows the user\'s profile picture' do
    expect(page).to have_css('img[alt="User Image"]')
  end

  it 'shows the number of posts the user has written' do
    expect(page).to have_content("Number of posts: #{@user.posts.count}")
  end

  it 'shows the user\'s bio' do
    expect(page).to have_content(@user.bio)
  end

  it 'shows the user\'s first 3 posts' do
    @posts.first(3).each do |post|
      expect(page).to have_content(post.title)
      expect(page).to have_content(post.text)
    end
  end

  it 'shows a button that lets me view all of a user\'s posts' do
    expect(page).to have_link('See all posts', href: user_posts_path(@user))
  end

  it 'redirects to a post\'s show page when clicking a user\'s post' do
    first_post = @posts.first
    within find('div.post-summary', text: first_post.title) do
      click_on 'Read Post'
    end
    expect(page).to have_current_path(post_path(first_post))
  end

  it 'redirects to the user\'s posts index page when clicking to see all posts' do
    click_on('See all posts', match: :first)
    expect(page).to have_current_path(user_posts_path(@user))
  end
end
