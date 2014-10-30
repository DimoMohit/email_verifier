class CreateAccountsFiles < ActiveRecord::Migration
  def change
    create_table :accounts_files do |t|
      t.string :name
      t.string :email_file
      t.timestamps
    end
  end
end
