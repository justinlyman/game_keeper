require 'rails_helper'

RSpec.describe BorrowersController, type: :controller do

  before(:each) do
    @borrower = FactoryGirl.create(:borrower)
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
      get :edit, id: @borrower.id
      expect(response).to be_success # 200 Success
      expect(response).to render_template(:edit)
    end
  end

  describe 'PATCH update' do
    it 'updates borrower record and redirects to index' do
      patch :update, {id: @borrower.id, borrower: {first_name: 'Bobby', last_name: 'Tester'}}
      expect(response.status).to eq(302) # 302 Redirect
      expect(response).to redirect_to :borrowers
      expect(flash[:notice]).to eq('Borrower updated')
      @borrower.reload
      expect(@borrower.first_name).to eq('Bobby')
      expect(@borrower.last_name).to eq('Tester')
    end

    it 'renders edit if borrower is not updated' do
      patch :update, {id: @borrower.id, borrower: {first_name: nil}}
      expect(response).to be_success # 200 Success
      expect(response).to render_template(:edit)
    end
  end

  describe 'GET new' do
    it 'renders new action and template' do
      get :new
      expect(response).to be_success # 200 Success
      expect(response).to render_template(:new)
    end
  end

  describe 'POST create' do
    before(:each) do
      @borrower_attributes = FactoryGirl.attributes_for :borrower
    end

    it 'creates borrower record and redirects to index' do
      expect(Borrower.count).to eq(1)
      post :create, {borrower: @borrower_attributes}
      expect(response.status).to eq(302) # 302 Redirect
      expect(response).to redirect_to :borrowers
      expect(flash[:notice]).to eq('Borrower created')
      expect(Borrower.count).to eq(2)
    end

    it 'renders new if borrower is not created' do
      @borrower_attributes[:first_name] = nil
      post :create, {borrower: @borrower_attributes}
      expect(response).to be_success # 200 Success
      expect(response).to render_template(:new)
    end
  end

  describe 'DELETE destroy' do
    it 'deletes borrower record' do
      delete :destroy, {id: @borrower.id}
      expect(response.status).to eq(302) # 302 Redirect
      expect(response).to redirect_to :borrowers
      expect(flash[:notice]).to eq('Borrower destroyed')
    end
  end

end
