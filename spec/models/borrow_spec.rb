require 'rails_helper'

RSpec.describe Borrow, type: :model do

  describe 'associations' do
    it 'belongs_to borrower' do
      expect(Borrow.reflect_on_association(:borrower).macro).to eq(:belongs_to)
    end

    it 'belongs_to game' do
      expect(Borrow.reflect_on_association(:game).macro).to eq(:belongs_to)
    end
  end
  
  describe 'validations' do
    it 'validates presence of borrower_id' do
      borrow = FactoryGirl.build(:borrow, borrower: nil)
      expect(borrow).to_not be_valid
    end

    it 'validates presence of game_id' do
      borrow = FactoryGirl.build(:borrow, game: nil)
      expect(borrow).to_not be_valid
    end
  end

end
