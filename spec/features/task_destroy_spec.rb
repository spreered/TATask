require 'rails_helper'

RSpec.feature "TasksDestroy", type: :feature do
  before(:each) do
    @task = FactoryBot.create(:task)
  end
  scenario "delete tasks from index pages" do
    visit tasks_path
    expect{
        find("a.btn-delete").click
    }.to change{ Task.count }.by(-1)
  end
  scenario "delete tasks from task show pages" do
    visit task_path(@task)
    expect{
      find("a.btn-delete").click
    }.to change{ Task.count }.by(-1)

  end
end
