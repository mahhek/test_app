class UserMailer < ActionMailer::Base
  #  default from: "test.account.rac@gmail.com"

  default from: "noreply@pogomd.com"

  def new_user_email(user, password)
    @user = user
    @password = password
    mail(to: @user.email, cc: "hipaaone@mailinator.com", subject: 'Welcome to Hipaa Security Suite!', content_type: 'text/html')
  end

  def edit_user_password(user, password)
    @user = user
    @password = password
    mail(to: @user.email, cc: "hipaaone@mailinator.com", subject: 'Hipaa Security Suite : Your password was Updated!', content_type: 'text/html')
  end

  def client_info_mail_to_admin(client)
    @client = client
    @admin = User.find_by_role("admin")
    mail(to: @admin.email, cc: "hipaaone@mailinator.com", subject: 'Hipaa Security Suite : Client Info Sheet for Admin!', content_type: 'text/html')
  end
end
