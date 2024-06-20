class CreateBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.date :publication_date
      t.string :genre
      t.boolean :status
      t.integer :quantity
      t.timestamps
    end
  end
end
