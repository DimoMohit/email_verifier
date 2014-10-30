class AccountsFile < ActiveRecord::Base
	mount_uploader :email_file, EmailUploader
	has_many :accounts
end
