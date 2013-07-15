class UserMailer < ActionMailer::Base
  default from: "test.account.rac@gmail.com"

  def new_user_email(user, password)
    @user = user
    @password = password
    mail(to: @user.email, cc: "mahhek.khan@gmail.com", subject: 'Welcome to Hipaa Security Suite!', content_type: 'text/html')
  end

  def edit_user_password(user, password)
    @user = user
    @password = password
    mail(to: @user.email, cc: "mahhek.khan@gmail.com", subject: 'Hipaa Security Suite : Your password was Updated!', content_type: 'text/html')
  end

  def client_info_mail_to_admin(client)
    @client = client
   
    mail(to: "mahhek.khan@gmail.com", subject: 'Hipaa Security Suite : Client Info Sheet for Admin!', content_type: 'text/html')
  end
end
