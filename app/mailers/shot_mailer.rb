class ShotMailer < ActionMailer::Base
  default from: 'notifications@hospitium.co'

  def reminder_email(shot)
    @user = shot.organization.owner
    @shot = shot
    mail(to: @user.email, subject: 'A shot is about to expire.')
  end
end
