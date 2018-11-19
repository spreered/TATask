require 'rails_helper'

RSpec.feature "TasksShow", type: :feature do
  let(:user) { FactoryBot.create(:user) } 
  let(:task) {FactoryBot.create(:task, user_id: user.id) }
  # login
  before(:each) do 
    visit login_path 
    fill_in 'session_email',    with: user.email
    fill_in 'session_password', with: user.password
    click_button I18n.t('views.user.login')
  end
  scenario 'index page can visit show page' do
    task
    visit tasks_path
    click_link task.title
    expect(page).to have_content task.title
    expect(page).to have_content task.content
  end
end
