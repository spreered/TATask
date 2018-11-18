require 'rails_helper'

RSpec.feature 'TasksUpdate', type: :feature do
  before(:each) do
    @task = FactoryBot.create(:task)
  end
  scenario 'update tasks from index pages' do
    visit tasks_path
    find('a.btn-edit').click
    expect(page).to have_current_path(edit_task_path(@task))
    fill_in 'task[title]',	with: 'my test task'
    fill_in 'task[content]', with: 'to do content' 
    click_button I18n.t('views.submit_btn')
    expect(page).to have_current_path(task_path(@task))
    expect(page).to have_content('my test task')

    expect(@task.reload.title).to match('my test task')  
    expect(@task.content).to match('to do content')  
  end
  scenario 'update tasks from show pages' do
    visit task_path(@task)
    find('a.btn-edit').click
    expect(page).to have_current_path(edit_task_path(@task))
    fill_in 'task[title]',	with: 'my test task'
    fill_in 'task[content]', with: 'to do content' 
    click_button I18n.t('views.submit_btn')
    expect(page).to have_current_path(task_path(@task))
    expect(page).to have_content('my test task')

    expect(@task.reload.title).to match('my test task')
    expect(@task.content).to match('to do content')
  end
end
