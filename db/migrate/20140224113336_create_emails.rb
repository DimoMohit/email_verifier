class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      
      t.string :name,:limit=>400
      t.string :from,:limit=>800
      t.string :message,:limit=>5000

      t.timestamps
    end
  end
end
