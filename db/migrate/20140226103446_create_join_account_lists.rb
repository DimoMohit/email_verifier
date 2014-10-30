class CreateJoinAccountLists < ActiveRecord::Migration
  def change
    create_table :join_account_lists do |t|
      t.belongs_to :account_list
      t.belongs_to :account
      t.timestamps
    end
  end
end
