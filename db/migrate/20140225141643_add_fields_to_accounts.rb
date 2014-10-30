class AddFieldsToAccounts < ActiveRecord::Migration
  def change
  	add_column :accounts,:salary,:string,:limit=>15
  	add_column :accounts,:gender,:string,:limit=>15
  	add_column :accounts,:age,:string,:limit=>15
  	add_column :accounts,:state,:string,:limit=>120
  end
end
