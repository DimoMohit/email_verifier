class BelonToAccounts < ActiveRecord::Migration
  def change
  	change_table :accounts do |t|
  	  t.belongs_to :accounts_file
  	end
  end
end
