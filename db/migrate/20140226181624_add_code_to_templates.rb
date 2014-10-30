class AddCodeToTemplates < ActiveRecord::Migration
  def change
  	add_column :templates,:code,:blob
  	add_column :templates,:text_code,:text
  end
end
