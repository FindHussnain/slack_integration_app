class Users::RegistrationsController < Devise::RegistrationsController
  def create
    super do |user|
      if user.persisted?
        SlackNotifier.send_message("*New User Signed Up!* 🎉\nName: *#{user.name}*\nEmail: _#{user.email}_")
      end
    end
  end
end
