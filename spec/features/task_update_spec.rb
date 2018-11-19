require 'rails_helper'

RSpec.feature 'TasksUpdate', type: :feature do

  let(:user) { FactoryBot.create(:user) } 
  let(:task) { FactoryBot.create(:task, user_id: user.id) } 
  # login
  before(:each) { 
    visit login_path 
    fill_in 'session_email',    with: user.email
    fill_in 'session_password', with: user.password
    click_button I18n.t('views.user.login')
  }

  scenario 'update tasks from index pages' do
    task
    visit tasks_path
    find('a.btn-edit').click
    expect(page).to have_current_path(edit_task_path(task))
    fill_in 'task[title]',	with: 'my test task'
    fill_in 'task[content]', with: 'to do content' 
    click_button I18n.t('views.submit_btn')
    expect(page).to have_current_path(task_path(task))
    expect(page).to have_content('my test task')

    expect(task.reload.title).to match('my test task')  
    expect(task.content).to match('to do content')  
  end
  scenario 'update tasks from show pages' do
    visit task_path(task)
    find('a.btn-edit').click
    expect(page).to have_current_path(edit_task_path(task))
    fill_in 'task[title]',	with: 'my test task'
    fill_in 'task[content]', with: 'to do content' 
    click_button I18n.t('views.submit_btn')
    expect(page).to have_current_path(task_path(task))
    expect(page).to have_content('my test task')

    expect(task.reload.title).to match('my test task')
    expect(task.content).to match('to do content')
  end
end
