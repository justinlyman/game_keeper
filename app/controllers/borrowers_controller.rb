class BorrowersController < ApplicationController

  before_action :set_borrower, only: [:edit, :update, :destroy]

  def index
    @borrowers = Borrower.all
  end

  def new
    @borrower = Borrower.new
  end

  def create
    @borrower = Borrower.new(borrower_params)
    if @borrower.save
      redirect_to :borrowers, notice: 'Borrower created'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @borrower.update_attributes(borrower_params)
      redirect_to :borrowers, notice: 'Borrower updated'
    else
      render :edit
    end
  end

  def destroy
    if @borrower.outstanding_borrows.count > 0
      redirect_to :borrowers, flash: { error: "You must check in all borrowed games before removing borrower" }
    else
      @borrower.destroy
      redirect_to :borrowers, notice: 'Borrower destroyed'
    end
  end

private

  def set_borrower
    @borrower = Borrower.find(params[:id])
  end

  def borrower_params
    params.require(:borrower).permit(:first_name, :last_name)
  end
end
