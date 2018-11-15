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
  scenario "task would ordered by time" do
    task_1 = FactoryBot.create(:task, created_at: Time.now.yesterday)
    task_2 = FactoryBot.create(:task, created_at: Time.now)

    visit tasks_path
    puts task_1.title
    puts task_2.title
    # page.should have_selector("table tbody tr:nth-child(1) td:nth-child(2)", content: task_1.title)
    # page.should have_selector("table tbody tr:nth-child(2) td:nth-child(2)", content: task_2.title)
    expect(find('table tbody tr:nth-child(1) td:nth-child(2)')).to have_content(task_2.title)
    expect(find('table tbody tr:nth-child(2) td:nth-child(2)')).to have_content(task_1.title)
  end

end
