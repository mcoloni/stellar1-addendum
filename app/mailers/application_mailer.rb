class ApplicationMailer < ActionMailer::Base
  default from: 'stellar1.udine@gmail.com'
  layout 'mailer'

  def Notification_Mailer(user)
    @user = user
    mail(to: @user.email, subject:'Avviso di scadenza tessera')
  end
  
end
