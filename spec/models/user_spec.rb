require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) do
    FactoryBot.create(:user)
  end
  it 'is valid with name and email' do
    user
    expect(user).to be_valid
  end
  it 'is invalid without name' do
    user_1 = User.new(name:nil, email:'abc@123')
    expect(user_1.valid?).to be false
  end
  it 'is invalid without email' do
    user_1 = User.new(name:'user 1', email: nil)
    expect(user_1.valid?).to be false
  end
  it 'would check email valid?' do
    user_1 = User.new(name:'user 1', email: 'abcemail')
    expect(user_1.valid?).to be false
  end
end
