class Borrow < ActiveRecord::Base
  belongs_to :borrower
  belongs_to :game

  validates :borrower_id, presence: true
  validates :game_id, presence: true
end
