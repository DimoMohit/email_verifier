class AddHeaderAndSubjectToEmails < ActiveRecord::Migration
  def change
  	add_column :emails,:header,:string
  	add_column :emails,:subject,:string
  end
end
