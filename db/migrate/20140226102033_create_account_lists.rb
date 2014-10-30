class CreateAccountLists < ActiveRecord::Migration
  def change
    create_table :account_lists do |t|
      t.string :name,:limit=>70
      t.timestamps
    end
  end
end
