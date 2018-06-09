module Users
  class << self
    delegate :find_by_id, :find_by_email, to: :user_class

    def create(session: nil, **create_params)
      user = user_class.create(create_params)

      if user.persisted? && session
        user.mark_as_authenticated
        store_session_user(session: session, user: user)
      end

      user
    end

    def email_exists?(email)
      user_class.where(email: email).any?
    end

    def authenticate(session:, email:, password:)
      user = find_by_email(email)
      return nil unless user

      if user.authenticate(password)
        user.mark_as_authenticated
        store_session_user(session: session, user: user)
      end

      user
    end

    def from_session(session)
      if (user = find_by_id(session_user_id(session)))
        user.mark_as_authenticated
        return user
      end

      guest
    end

    def guest
      guest_user_class.new
    end

  private

    def session_user_id(session)
      session.to_h.symbolize_keys.dig(:user, :id)
    end

    def store_session_user(session:, user:)
      session[:user] ||= {}
      session[:user][:id] = user.id
    end

    def user_class
      User
    end

    def guest_user_class
      User::Guest
    end
  end
end
