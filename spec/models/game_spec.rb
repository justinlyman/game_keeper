require 'rails_helper'

RSpec.describe Game, :type => :model do
  it 'can be instantiated' do
    expect(Game.new).to_not be_nil
  end

  describe 'associations' do
    it 'has_many borrows' do
      expect(Game.reflect_on_association(:borrows).macro).to eq(:has_many)
    end

    it 'has_many borrowers' do
      expect(Game.reflect_on_association(:borrowers).macro).to eq(:has_many)
    end
  end

  describe 'validations' do
    it 'validates presence of name' do
      game = FactoryGirl.build(:game, name: nil)
      expect(game).to_not be_valid
    end
  end

  describe 'self.available' do
    before(:each) do
      @game = FactoryGirl.create(:game)
      @game2 = FactoryGirl.create(:game)
      @game3 = FactoryGirl.create(:game)
      @borrower = FactoryGirl.create(:borrower)
    end
    it 'returns all available games' do
      borrow = FactoryGirl.create(:borrow, borrower: @borrower, game: @game2, checked_in: nil)
      borrow = FactoryGirl.create(:borrow, borrower: @borrower, game: @game3, checked_in: Time.now)
      expect(Game.count).to eq(3)
      expect(Game.available.count).to eq(2)
      Game.available.each do |game|
        expect(game.available?).to be true
      end
    end
  end

  describe 'available? method' do
    before(:each) do
      @game = FactoryGirl.create(:game)
      @borrower = FactoryGirl.create(:borrower)
    end

    it 'returns true if game has 0 borrows'  do
      expect(@game.available?).to be true
    end

    it 'returns false if has borrows and last borrow checked in is blank' do
      borrow = FactoryGirl.create(:borrow, borrower: @borrower, game: @game, checked_in: nil)
      expect(@game.available?).to be false
    end

    it 'returns true if has borrows and last borrow checked in is not blank' do
      borrow = FactoryGirl.create(:borrow, borrower: @borrower, game: @game, checked_in: Time.now)
      expect(@game.available?).to be true
    end
  end
end