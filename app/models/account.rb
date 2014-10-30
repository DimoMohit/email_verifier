class Account < ActiveRecord::Base
	belongs_to :email
	belongs_to :accounts_file
	has_many :join_account_lists
	validates :email_address,uniqueness: true, presence: true
	has_many :account_lists, :through=>:join_account_lists
end
