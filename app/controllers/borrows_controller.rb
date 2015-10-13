class BorrowsController < ApplicationController

  before_action :set_borrow, only: [:update]

  def new
    @borrow = Borrow.new
    @label = 'Lend Game'
    @available = Game.available
  end

  def create
    @game = Game.find(borrow_params[:game_id])
    @borrow = Borrow.new(borrow_params)
    if @game.available?
      if @borrow.save
        redirect_to :games, notice: 'Game borrowed successfully'
      else
        redirect_to :games, flash: { error: 'There was a problem borrowing game' }
      end
    else
      render :new, flash: { error: 'Game already being borrowed' }
    end
  end

  def update
    @borrow.update_attributes(checked_in: Time.now)
    redirect_to :games, notice: 'Game checked in successfully'
  end

private

  def set_borrow
    @borrow = Borrow.find(params[:id])
  end

  def borrow_params
    params.require(:borrow).permit(:borrower_id, :game_id)
  end


end
