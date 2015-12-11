class OauthController < Devise::OmniauthCallbacksController
  def google_oauth2
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      flash[:success] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
      sign_in @user
      redirect_to setup_path
    else
      session["devise.google_data"] = request.env["omniauth.auth"]
      redirect_to setup_path
    end
  end
end
