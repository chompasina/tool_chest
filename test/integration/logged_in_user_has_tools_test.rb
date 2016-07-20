require 'test_helper'

class LoggedInUserHasToolsTest < ActionDispatch::IntegrationTest

  test 'user can see tools' do
    user = User.create(username: "Andrew", password: "password")
    tool = Tool.create(name: "Axe", quantity: 2, price: 12)
    user.tools << tool

    visit login_path
    fill_in 'session[username]', with: "Andrew"
    fill_in 'session[password]', with: "password"
    click_on("Click to log in")

    assert page.has_content?("Tools")
    assert page.has_content?("Axe")
  end

  test 'one user does not see tools of another' do
    user1 = User.create(username: "Crystal", password: "password")
    tool1 = Tool.create(name: "Drill", quantity: 2, price: 12)
    user1.tools << tool1

    user2 = User.create(username: "Dad", password: "password")
    tool2 = Tool.create(name: "Shovel", quantity: 5, price: 20)
    user2.tools << tool2
    #set up: create two users with tools, but only log one of them in, but they only see their tools, not the other users

    visit login_path
    fill_in 'session[username]', with: "Crystal"
    fill_in 'session[password]', with: "password"
    click_on("Click to log in")

    assert page.has_content?("Tools")
    assert page.has_content?("Drill")
    refute page.has_content?("Shovel")
    refute page.has_content?("Axe")
  end
end
