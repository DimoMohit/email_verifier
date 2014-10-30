class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.belongs_to :email
      t.string :name,:limit=>70
      t.string :email_address,:limit=>200
      t.string :phone,:limit=>15
      t.timestamps
    end
  end
end
