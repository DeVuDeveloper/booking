class AddHashedPasswordToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :hashed_password, :string
    add_column :users, :hashed_session_token, :string
    remove_column :users, :password, :string
  end
end
