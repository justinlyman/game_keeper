require 'rails_helper'

RSpec.describe GamesController, :type => :controller do

  before(:each) do
    @game = FactoryGirl.create(:game)
  end

  describe 'GET index' do
    it 'renders index action and template' do
      get :index
      expect(response).to be_success # 200 Success
      expect(response).to render_template(:index)
    end
  end

  describe 'GET edit' do
    it 'renders edit action and template' do
      get :edit, id: @game.id
      expect(response).to be_success # 200 Success
      expect(response).to render_template(:edit)
    end
  end

  describe 'PATCH update' do
    it 'updates game record and redirects to index' do
      patch :update, {id: @game.id, game: {name: 'Updated Title'}}
      expect(response.status).to eq(302) # 302 Redirect
      expect(response).to redirect_to :games
      expect(flash[:notice]).to eq('Game updated')
      @game.reload
      expect(@game.name).to eq('Updated Title')
    end

    it 'renders edit if game is not updated' do
      patch :update, {id: @game.id, game: {name: nil}}
      expect(response).to be_success # 200 Success
      expect(response).to render_template(:edit)
    end
  end

  describe 'GET new' do
    it 'renders new action and remplate' do
      get :new
      expect(response).to be_success # 200 Success
      expect(response).to render_template(:new)
    end
  end

  describe 'POST create' do
    before(:each) do
      @game_attributes = FactoryGirl.attributes_for :game
    end

    it 'creates game record and redirects to index' do
      expect(Game.count).to eq(1)
      post :create, {game: @game_attributes}
      expect(response.status).to eq(302) # 302 Redirect
      expect(response).to redirect_to :games
      expect(flash[:notice]).to eq('Game created')
      expect(Game.count).to eq(2)
    end

    it 'renders new if game is not created' do
      @game_attributes[:name] = nil
      post :create, {game: @game_attributes}
      expect(response).to be_success # 200 Success
      expect(response).to render_template(:new)
    end
  end

  describe 'DELETE destroy' do
    it 'deletes game record' do
      delete :destroy, {id: @game.id}
      expect(response.status).to eq(302) # 302 Redirect
      expect(response).to redirect_to :games
      expect(flash[:notice]).to eq('Game destroyed')
    end
  end

end