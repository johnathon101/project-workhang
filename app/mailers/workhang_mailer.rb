class WorkhangMailer < ActionMailer::Base
  default from: "us@workhang.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.workhang_mailer.welcome.subject
  #
  def welcome
    user = current_user
    @greeting = "Hi"

    mail to: user.email
  end
end
