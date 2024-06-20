class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :role

      t.timestamps
    end
    add_index :users, :email, unique: true
    add_reference(:users, :role, foreign_key: { to_table: :roles,column: :role_name, on_delete: :cascade, on_update: :cascade})
  end
end
