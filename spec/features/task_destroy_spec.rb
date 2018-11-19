require 'rails_helper'

RSpec.feature "TasksDestroy", type: :feature do
  let(:user) { FactoryBot.create(:user) } 
  let(:task) {FactoryBot.create(:task, user_id: user.id) }
  # login
  before(:each) do 
    visit login_path 
    fill_in 'session_email',    with: user.email
    fill_in 'session_password', with: user.password
    click_button I18n.t('views.user.login')
  end
  scenario "delete tasks from index pages" do
    task
    visit tasks_path
    expect{
        find("a.btn-delete").click
    }.to change{ Task.count }.by(-1)
  end
  scenario "delete tasks from task show pages" do
    visit task_path(task)
    expect{
      find("a.btn-delete").click
    }.to change{ Task.count }.by(-1)

  end
end
