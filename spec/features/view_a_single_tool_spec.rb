require 'rails_helper'

describe "View a single tool", :type => :feature do
  scenario "User views a tool" do
    visit tools_path
    #same as: visit "/tools" or visit '/'

    click_link "Hammer"
    visit tool_path
    #same as: visit "/tools/:id"

     within(".single_tool") do
      expect(page).to have_content("Hammer")
      expect(page).to have_content("50.0")
     end
  end
end
