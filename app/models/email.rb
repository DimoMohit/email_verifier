class Email < ActiveRecord::Base
	has_many :accounts
	has_one :email_status	
end
