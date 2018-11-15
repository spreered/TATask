require 'rails_helper'

RSpec.feature "TasksIndex", type: :feature do
  let(:task) do
    FactoryBot.create(:task)
  end
  scenario "index page can see tasks" do
    task
    visit tasks_path
    expect(page).to have_content task.title
  end

end
