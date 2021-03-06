module Session
  class Create
    include ActiveModel::Model

    def self.model_name
      ActiveModel::Name.new(self, nil, "Session")
    end

    attr_accessor :email, :password
    attr_reader :user

    validate :ensure_email_exists

    def call(session)
      return false unless valid?

      authenticate_user(session)

      user&.authenticated?
    end

  private

    def ensure_email_exists
      return if user_repository.email_exists?(email)

      errors.add(:base, :invalid_credentials)
    end

    def authenticate_user(session)
      @user = user_repository.authenticate(session: session, email: email, password: password)

      errors.add(:base, :invalid_credentials) unless user&.authenticated?
    end

    def user_repository
      @user_repository ||= UserRepository.new
    end
  end
end
