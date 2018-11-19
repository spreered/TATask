require 'rails_helper'

RSpec.feature 'TasksIndex', type: :feature do
  let(:user_1) { FactoryBot.create(:user) } 
  let(:user_2) { FactoryBot.create(:user) } 
  # login
  before(:each) { visit login_path }

  describe 'with valid information' do
    before(:each) do 
      fill_in 'session_email',    with: user_1.email
      fill_in 'session_password', with: user_1.password
      click_button I18n.t('views.user.login')
    end

    describe 'tasks' do
      it 'should be seen by creator' do
        task = FactoryBot.create(:task, user_id: user_1.id)
        visit tasks_path
        expect(page).to have_content task.title
      end
      it 'should not be seen by others' do
        task = FactoryBot.create(:task, user_id: user_2.id)
        visit tasks_path
        expect(page).not_to have_content task.title
      end
    end
    
    describe 'could be ordered' do
      let(:task_1) do
        FactoryBot.create(
          :task, 
          created_at: Time.now.yesterday, 
          user_id: user_1.id
        )
      end
      let(:task_2) do
        FactoryBot.create(
          :task, :deadline_next_week, :high_priority,
          created_at: Time.now, 
          user_id: user_1.id
        )
      end
      it 'by created_at desc default' do
        task_1
        task_2
        visit tasks_path
        expect(find('table tbody tr:nth-child(1) td:nth-child(3)')).to have_content(task_2.title)
        expect(find('table tbody tr:nth-child(2) td:nth-child(3)')).to have_content(task_1.title)
      end
      it 'by deadline' do
        task_1
        task_2
        visit tasks_path 
        click_link I18n.t('views.tasks.deadline')
        expect(find('table tbody tr:nth-child(1) td:nth-child(3)')).to have_content(task_2.title)
        expect(find('table tbody tr:nth-child(2) td:nth-child(3)')).to have_content(task_1.title)
        click_link I18n.t('views.tasks.deadline')
        expect(find('table tbody tr:nth-child(1) td:nth-child(3)')).to have_content(task_1.title)
        expect(find('table tbody tr:nth-child(2) td:nth-child(3)')).to have_content(task_2.title)
      end
      it 'by priority' do
        task_1
        task_2
        visit tasks_path
        click_link I18n.t('views.tasks.priority_t')

        expect(find('table tbody tr:nth-child(1) td:nth-child(3)')).to have_content(task_2.title)
        expect(find('table tbody tr:nth-child(2) td:nth-child(3)')).to have_content(task_1.title)
        click_link I18n.t('views.tasks.priority_t')
        expect(find('table tbody tr:nth-child(1) td:nth-child(3)')).to have_content(task_1.title)
        expect(find('table tbody tr:nth-child(2) td:nth-child(3)')).to have_content(task_2.title)
      end
    end

    describe 'could be searched' do
      let(:task_1) { FactoryBot.create(:task, user_id: user_1.id) }
      let(:task_2) { FactoryBot.create( :task, :completed_state, user_id: user_1.id) }
      it 'by title' do
        task_1
        task_2
        visit tasks_path
        fill_in 'q[title_cont]',	with: task_1.title
        click_button I18n.t('ransack.search')
        expect(page).to have_content(task_1.title)
        expect(page).not_to have_content(task_2.title)
      end
      scenario 'by state' do
        task_1
        task_2
        visit tasks_path
        select I18n.t('views.tasks.state.completed'),	from: 'q[state_eq]'
        click_button I18n.t('ransack.search')
        expect(page).to have_content(task_2.title)
        expect(page).not_to have_content(task_1.title)
      end
    end
  end

  describe 'without login' do
    it 'should redirect to login path' do
      visit tasks_path
      expect(page).to have_current_path(login_path)
    end
  end

end
