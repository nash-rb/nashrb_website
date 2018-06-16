class UserRepository < Hanami::Repository
  def sign_up(session: nil, **create_params)
    create_params[:password_digest] ||= BCrypt::Password.create(create_params.delete(:password))
    user = create(create_params)

    if user && session
      user = AuthenticatedUser.new(user)
      store_session_user(session: session, user: user)
    end

    user
  end

  def email_exists?(email)
    find_by_email(email).present?
  end

  def find_by_email(email)
    users.where(email: email).first
  end

  def authenticate(session:, email:, password:)
    user = find_by_email(email)
    return nil unless user

    if BCrypt::Password.new(user.password_digest) == password
      user = AuthenticatedUser.new(user)
      store_session_user(session: session, user: user)
    end

    user
  end

  def from_session(session)
    if (user = find(session_user_id(session)))
      return AuthenticatedUser.new(user)
    end

    guest
  end

  def guest
    User::Guest.new
  end

private

  def session_user_id(session)
    session.to_h.symbolize_keys.dig(:user, :id)
  end

  def store_session_user(session:, user:)
    session[:user] ||= {}
    session[:user][:id] = user.id
  end
end
