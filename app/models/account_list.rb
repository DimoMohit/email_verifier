class AccountList < ActiveRecord::Base
    has_many :join_account_lists
	has_many :account, :through=>:join_account_lists
end
