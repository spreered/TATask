require 'rails_helper'

RSpec.feature "TasksShow", type: :feature do
  before(:each) do
    @task = FactoryBot.create(:task)
  end
  scenario "index page can visit show page" do
    visit tasks_path
    click_link @task.title
    expect(page).to have_content @task.title
    expect(page).to have_content @task.content
  end
end
