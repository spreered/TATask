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
  scenario "task would default ordered by created_at time" do
    task_1 = FactoryBot.create(:task, created_at: Time.now.yesterday)
    task_2 = FactoryBot.create(:task, created_at: Time.now)

    visit tasks_path
    expect(find('table tbody tr:nth-child(1) td:nth-child(3)')).to have_content(task_2.title)
    expect(find('table tbody tr:nth-child(2) td:nth-child(3)')).to have_content(task_1.title)
  end
  scenario "tasks could ordered by deadline desc and asc" do
    task_1 = FactoryBot.create(:task, :deadline_next_week)
    task_2 = FactoryBot.create(:task, :deadline_next_2_week)

    visit tasks_path
    click_link I18n.t('views.tasks.deadline')
    expect(find('table tbody tr:nth-child(1) td:nth-child(3)')).to have_content(task_2.title)
    expect(find('table tbody tr:nth-child(2) td:nth-child(3)')).to have_content(task_1.title)
    click_link I18n.t('views.tasks.deadline')
    expect(find('table tbody tr:nth-child(1) td:nth-child(3)')).to have_content(task_1.title)
    expect(find('table tbody tr:nth-child(2) td:nth-child(3)')).to have_content(task_2.title)
  end
  scenario "tasks could ordered by priority desc and asc" do
    task_1 = FactoryBot.create(:task, )
    task_2 = FactoryBot.create(:task, :medium_priority)
    task_3 = FactoryBot.create(:task, :high_priority)

    visit tasks_path
    click_link I18n.t('views.tasks.priority_t')

    expect(find('table tbody tr:nth-child(1) td:nth-child(3)')).to have_content(task_3.title)
    expect(find('table tbody tr:nth-child(2) td:nth-child(3)')).to have_content(task_2.title)
    expect(find('table tbody tr:nth-child(3) td:nth-child(3)')).to have_content(task_1.title)
    click_link I18n.t('views.tasks.priority_t')
    expect(find('table tbody tr:nth-child(1) td:nth-child(3)')).to have_content(task_1.title)
    expect(find('table tbody tr:nth-child(2) td:nth-child(3)')).to have_content(task_2.title)
    expect(find('table tbody tr:nth-child(3) td:nth-child(3)')).to have_content(task_3.title)
  end

  scenario "tasks could be searched by title" do
    task_1 = FactoryBot.create(:task)
    task_2 = FactoryBot.create(:task)
    task_3 = FactoryBot.create(:task)
    visit tasks_path
    fill_in 'q[title_cont]',	with: task_1.title
    click_button I18n.t('ransack.search')
    expect(page).to have_content(task_1.title)
    expect(page).not_to have_content(task_2.title)
    expect(page).not_to have_content(task_3.title)
  end
  scenario "tasks could be searched by state" do
    task_1 = FactoryBot.create(:task)
    task_2 = FactoryBot.create(:task, :doing_state)
    task_3 = FactoryBot.create(:task, :completed_state)
    visit tasks_path
    select I18n.t('views.tasks.state.completed'),	from: 'q[state_eq]'
    click_button I18n.t('ransack.search')
    expect(page).to have_content(task_3.title)
    expect(page).not_to have_content(task_1.title)
    expect(page).not_to have_content(task_2.title)
  end



end
