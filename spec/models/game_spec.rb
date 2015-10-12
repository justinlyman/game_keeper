require 'rails_helper'

RSpec.describe Game, :type => :model do
  it 'can be instantiated' do
    expect(Game.new).to_not be_nil
  end

  describe 'validations' do
    it 'validates presence of name' do
      game = FactoryGirl.build(:game, name: nil)
      expect(game).to_not be_valid
    end
  end
end