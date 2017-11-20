 # La classe crea un messaggio per essere spedita via mail.

class UserMailer < ApplicationMailer
  default from: 'stellar1.udine@gmail.com'

  def Notification_Mailer(user)
    @user = user
    mail(to: @user.email, subject:'Avviso di scadenza tessera')
  end

end
