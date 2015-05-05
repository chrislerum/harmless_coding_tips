require 'rails_helper'

feature "Showing posts" do
  scenario "Show a post" do
    post = Post.new
    post.title = 'The Title'
    post.content = "hello post"
    post.save
    visit root_path
    click_link 'The Title'
    expect(page).to have_content('hello post')
  end
end

feature "Don't show sign up sign in" do
  scenario "index page" do
    visit root_path
    expect(page).to have_no_link('Sign Up')
    expect(page).to have_no_link('Sign In')
  end
end
