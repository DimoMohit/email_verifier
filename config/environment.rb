# Load the Rails application.
require File.expand_path('../application', __FILE__)

ActionMailer::Base.smtp_settings = {
	#:domain => 'abcd.in',
	#:address => "foo@gmail.com",
	:port => 587,
	:authentication => :plain,
	:enable_stattls_auto => true
}

ActionMailer::Base.sendmail_settings = {
        :location => '/usr/sbin/sendmail',
        :arguments => '-i -t'
}


# Initialize the Rails application.
Emailsender::Application.initialize!
