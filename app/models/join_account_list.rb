class JoinAccountList < ActiveRecord::Base
	belongs_to :account
	belongs_to :account_list
end
