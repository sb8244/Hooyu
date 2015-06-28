class User < ActiveRecord::Base
  devise :omniauthable, :omniauth_providers => [:google_oauth2]

  def people
    @people ||= Person.where(user_id: id).to_a
  end

  def domain
    email.split("@").last.downcase
  end

  def self.from_omniauth(access_token)
    data = access_token.info

    User.where(email: data["email"]).first_or_create!(
       email: data["email"],
       first_name: data["first_name"],
       last_name: data["last_name"]
    )
  end

  def reload
    super.tap do
      @people = nil
    end
  end
end
