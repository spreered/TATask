require 'rails_helper'
RSpec.describe Task, type: :model do
  let(:task) do
    FactoryBot.create(:task)
  end
  context '#index' do
    it 'is valid with title and content' do
      task
      expect(task).to be_valid
    end
    it 'is invalid without title ' do
      task_1 = Task.new(title:nil)
      task_1.valid?
      expect(task_1.errors[:title]).to include(I18n.t('activerecord.errors.models.task.attributes.title.blank'))
    end

    describe 'can search tasks by ransack' do 
      let(:task_1){ FactoryBot.create(:task) }
      let(:task_2){ FactoryBot.create(:task, :completed_state) }
      
      it 'can be searched by title' do 
        task_1 
        task_2 
        # get tasks_path(q:{title_cont: task_1.title})
        q = {title_cont: task_1.title}
        tasks = Task.ransack(q).result
        expect(tasks.count).to eq 1  
        expect(tasks.first.id).to eq task_1.id  
      end
      it 'can be searched by state' do 
        task_1 
        task_2 
        q = {state_eq: task_2.state_before_type_cast}
        tasks = Task.ransack(q).result
        expect(tasks.count).to eq 1  
        expect(tasks.first.id).to eq task_2.id  
      end

    end
  end
end
