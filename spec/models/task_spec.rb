require 'rails_helper'
RSpec.describe Task, type: :model do
  let(:task) do
    FactoryBot.create(:task)
  end
  it 'is valid with title and content' do
    task
    expect(task).to be_valid
  end
  it 'is invalid without title ' do
    task_1 = Task.new(title:nil)
    task_1.valid?
    expect(task_1.errors[:title]).to include(I18n.t('activerecord.errors.models.task.attributes.title.blank'))
  end
end
