class Game < ActiveRecord::Base
  has_many :borrows
  has_many :borrowers, through: :borrows

  validates :name, presence: { message: 'Game name is required.' }

  def self.available
    all.includes(:borrows).select { |g| g if g.available? }
  end

  def available?
    if self.borrows.count > 0
      if self.borrows.last.checked_in.blank?
        false
      else
        true
      end
    else
      true
    end
  end

end
