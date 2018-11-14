require 'rails_helper'

RSpec.feature "TasksIndex", type: :feature do
  before(:each) do
    @task = FactoryBot.create(:task)
  end
  scenario "index page can see tasks" do
    visit tasks_path
    expect(page).to have_content "task title"
  end

end
