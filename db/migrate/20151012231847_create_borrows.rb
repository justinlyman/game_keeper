class CreateBorrows < ActiveRecord::Migration
  def change
    create_table :borrows do |t|
      t.references :borrower, index: true, foreign_key: true
      t.references :game, index: true, foreign_key: true
      t.datetime :checked_in

      t.timestamps null: false
    end
  end
end
