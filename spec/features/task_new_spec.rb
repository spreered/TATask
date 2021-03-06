require 'rails_helper'

RSpec.feature 'TasksNew', type: :feature do
  let(:user) { FactoryBot.create(:user) } 
  before(:each) do 
    visit login_path 
    fill_in 'session_email',    with: user.email
    fill_in 'session_password', with: user.password
    click_button I18n.t('views.user.login')
  end
  scenario 'create tasks from index pages' do
    # add temp

    visit tasks_path
    click_link I18n.t('views.new_task')
    expect(page).to have_content I18n.t('views.new_task')
    expect{
      fill_in 'task[title]',	with: 'my test task'
      fill_in 'task[content]', with: 'to do content' 
      click_button I18n.t('views.submit_btn')
      puts Task.all
      }.to change{ Task.count }.by(1)
  end
end
