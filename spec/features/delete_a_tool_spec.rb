require 'rails_helper'

describe "Delete a tool", :type => :feature do
  scenario "User can delete a tool" do
    Tool.create(name: "Axe", price: 1223, quantity: 2)

    visit tool_path(Tool.first)
    #same as: visit "/tools/new"
    expect(page).to have_content("Axe")

    click_on "Delete"

    expect(current_page).to eq(tools_path)

    within(".tool_info") do
      expect(page).to have_no_content("Axe")
     end
  end
end
