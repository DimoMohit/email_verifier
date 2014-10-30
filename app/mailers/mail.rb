class Mail < ActionMailer::Base
  default from: "webmaster@myapp.com"

  def hassle_email(user)
    @user = user
    mail(:to => user.email,
         :subject => "You have been Invited!")
  end
end
