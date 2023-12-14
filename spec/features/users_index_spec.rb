# spec/features/users_index_spec.rb:

require 'rails_helper'

RSpec.describe 'UsersIndex', type: :feature do
  before do
    @user1 = User.create!(name: 'User 1', email: 'user1@example.com', posts_counter: 0)
    @user2 = User.create!(name: 'User 2', email: 'user2@example.com', posts_counter: 0)
    3.times { Post.create!(author: @user1, title: 'Post', text: 'Text', comments_counter: 0, likes_counter: 0) }
    2.times { Post.create!(author: @user2, title: 'Post', text: 'Text', comments_counter: 0, likes_counter: 0) }
    visit users_path
  end

  it 'shows the username of all other users' do
    expect(page).to have_content(@user1.name)
    expect(page).to have_content(@user2.name)
  end

  it 'shows the profile picture for each user' do
    User.all.each do |user|
      next unless user.photo.present?

      within("div##{user.id}_user_container") do
        expect(page).to have_css('img')
      end
    end
  end

  it 'shows the number of posts each user has written' do
    expect(page).to have_content('Number of posts: 3', count: 1)
    expect(page).to have_content('Number of posts: 2', count: 1)
  end

  it 'redirects to user show page on click' do
    click_on @user1.name
    expect(page).to have_current_path(user_path(@user1))
  end
end
