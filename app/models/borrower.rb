class Borrower < ActiveRecord::Base
  has_many :borrows
  has_many :games, through: :borrows

  validates :first_name, presence: true
  validates :last_name, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end

  def outstanding_borrows
    borrows.select {|b| b if b.checked_in.blank? }
  end
end
