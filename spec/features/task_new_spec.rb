require 'rails_helper'

RSpec.feature "TasksNew", type: :feature do
  scenario "create tasks from index pages" do
    visit tasks_path
    click_link 'new task'
    expect(page).to have_content 'create task'
    expect{
      fill_in 'task[title]',	with: 'my test task'
      fill_in 'task[content]', with: 'to do content' 
      click_button 'create task'
      }.to change{Task.count}.by(1)
  end
end
