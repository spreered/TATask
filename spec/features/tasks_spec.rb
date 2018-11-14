require 'rails_helper'

RSpec.feature "Tasks", type: :feature do
  scenario "index page can see tasks" do
    FactoryBot.create(:task)
    visit tasks_path
    expect(page).to have_content "task title 1"
  end

end
