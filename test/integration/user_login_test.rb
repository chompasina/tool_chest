require 'test_helper'

class UserLoginTest < ActionDispatch::IntegrationTest
  test "a user can login successfully" do
    #as a user
    user = User.create(username: "Andrew", password: "password")
    #when I visit '/login'
    visit login_path
    #and I fill in my username and password
    fill_in 'session[username]', with: "Andrew"
    fill_in 'session[password]', with: "password"
    #and submit
    click_on("Click to log in")
    assert_equal user_path(user), current_path

    within("#greeting") do
      assert page.has_content?("Welcome, Andrew!")
  end
end

  test "a user can't login without incorrect password" do
    user = User.create(username: "Tom", password: "password")

    visit login_path
    fill_in 'session[username]', with: user.username
    #or could give the real hardcoded username`
    fill_in 'session[password]', with: 'fassword'

    click_on 'Click to log in'

    assert_equal login_path, current_path
    assert page.has_content?('invalid login')
  end

  test "a user can logout" do

    #as a logged in user
    #I shoul see my username
    #when I click 'logout
    user = User.create(username: "Tom", password: "password")
    # ApplicationController.any_instance.stubs(:current_user).returns( user )
    #I expect to be back to the route of the homepage

    visit login_path
    fill_in 'session[username]', with: user.username
    #or could give the real hardcoded username`
    fill_in 'session[password]', with: 'password'

    click_on 'Click to log in'
    assert page.has_content?("Tom")

    visit user_path(user)
    # page.find(".nav")
    # require "pry"; binding.pry
    click_on "Logout"

    assert_equal root_path, current_path
    refute page.has_content?("Tom")
  end
end
