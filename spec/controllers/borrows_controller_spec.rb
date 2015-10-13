require 'rails_helper'

RSpec.describe BorrowsController, type: :controller do

  describe 'GET new' do
    it 'renders new action and template' do
      get :new
      expect(response).to be_success # 200 Success
      expect(response).to render_template(:new)
    end
  end

  describe 'POST create' do
    before(:each) do
      @game = FactoryGirl.create(:game)
      @borrower = FactoryGirl.create(:borrower)
      @borrow_attributes = FactoryGirl.attributes_for(:borrow, game_id: @game.id, borrower_id: @borrower.id)
    end

    it 'creates borrow record and redirects to games' do
      expect(Borrow.count).to eq(0)
      post :create, {borrow: @borrow_attributes}
      expect(response.status).to eq(302) # 302 Redirect
      expect(response).to redirect_to :games
      expect(flash[:notice]).to eq('Game borrowed successfully')
      expect(Borrow.count).to eq(1)
    end

    it 'redirects to games if there is an error saving' do
      post :create, borrow: { game_id: @game.id, borrower_id: nil }
      expect(response.status).to eq(302) # 302 Redirect
      expect(response).to redirect_to :games
      expect(flash[:error]).to eq('There was a problem borrowing game')
    end

    it 'renders new if game is already borrowed' do
      FactoryGirl.create(:borrow, @borrow_attributes)
      post :create, {borrow: @borrow_attributes}
      expect(response).to be_success # 200 Success
      expect(response).to render_template(:new)
    end
  end

  describe 'PATCH update' do
    before(:each) do
      @game = FactoryGirl.create(:game)
      @borrower = FactoryGirl.create(:borrower)
      @borrow = FactoryGirl.create(:borrow, game_id: @game.id, borrower_id: @borrower.id)
    end
    it 'redirects to games after update' do
      patch :update, {id: @borrow.id}
      @borrow.reload
      expect(@borrow.checked_in).to_not be_blank
      expect(response.status).to eq(302) # 302 Redirect
      expect(response).to redirect_to :games
      expect(flash[:notice]).to eq('Game checked in successfully')
    end
  end
end
