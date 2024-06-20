class CreateManageBorrows < ActiveRecord::Migration[7.1]
  def change
    create_table :manage_borrows do |t|
      t.integer :bid
      t.integer :uid
      t.date :issue_date
      t.date :return_date

      t.timestamps
    end
    add_reference(:manage_borrows, :uid, foreign_key: { to_table: :users,column: :id, on_delete: :cascade, on_update: :cascade})
    add_reference(:manage_borrows, :bid, foreign_key: { to_table: :books, column: :id, on_delete: :cascade, on_update: :cascade})
  end
end
