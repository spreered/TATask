require 'rails_helper'

RSpec.feature "TasksDestroy", type: :feature do
  before(:each) do
    @task = FactoryBot.create(:task)
  end
  scenario "delete tasks from index pages" do
    visit tasks_path
    within("form[action^='/tasks/#{@task.id}']"){
      expect{
          click_button 'x'
      }.to change{ Task.count }.by(-1)
    }
  end
    scenario "delete tasks from task show pages" do
    visit task_path(@task)
    expect{
        click_link I18n.t('views.tasks.delete')
    }.to change{ Task.count }.by(-1)

  end
end
