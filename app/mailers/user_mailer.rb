class UserMailer < ActionMailer::Base
  default from: 'contact@abcd.com'
 
  def welcome_email(user,subject,message,from)
    @user = user
    @subject =subject
    @message=message
    @from=from
    @code=Template.last.text_code
    @url  = 'http://mohit.com'
    mail(to: @user.email_address, subject: @subject)
  end
end
