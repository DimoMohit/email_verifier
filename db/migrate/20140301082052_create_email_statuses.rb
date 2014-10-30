class CreateEmailStatuses < ActiveRecord::Migration
  def change
    create_table :email_statuses do |t|
      t.belongs_to :email
      t.integer :sent,:limit=>11
      t.integer :opened,:limit=>11
      t.integer :clicked,:limit=>11 
      t.timestamps
    end
  end
end
