require 'rails_helper'

RSpec.describe Borrower, type: :model do
  
  it 'can be instantiated' do
    expect(Borrower.new).to_not be_nil
  end

  describe 'associations' do
    it 'has_many borrows' do
      expect(Borrower.reflect_on_association(:borrows).macro).to eq(:has_many)
    end

    it 'has_many games' do
      expect(Borrower.reflect_on_association(:games).macro).to eq(:has_many)
    end
  end

  describe 'validations' do
    it 'validates presence of first_name' do
      game = FactoryGirl.build(:borrower, first_name: nil)
      expect(game).to_not be_valid
    end

    it 'validates presence of last_name' do
      game = FactoryGirl.build(:borrower, last_name: nil)
      expect(game).to_not be_valid
    end
  end

  describe 'full_name method' do
    before(:each) do
      @borrower = FactoryGirl.create(:borrower)
    end
    it 'returns first_name and last_name as combined string with space' do
      expect(@borrower.full_name).to eq('Jon Doe')
    end
  end

end
