class UserMailer < ActionMailer::Base
  default from: 'contact@fundsinn.com'
 
  def welcome_email(user,subject,message,from)
    @user = user
    @subject =subject
    @message=message
    @from=from
    @code=Template.last.text_code
    @url  = 'http://fundsinn.com'
    mail(to: @user.email_address, subject: @subject)
  end
end
