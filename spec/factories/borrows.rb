FactoryGirl.define do
  factory :borrow do
    borrower
    game
    checked_in nil
  end
end
