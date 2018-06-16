class User < Hanami::Entity
  class Create
    include ActiveModel::Model

    def self.model_name
      ActiveModel::Name.new(self, nil, "User")
    end

    attr_accessor :email, :password, :password_confirmation, :first_name, :last_name
    attr_reader :user

    validates_presence_of :email, :password, :password_confirmation, :first_name, :last_name
    validates_confirmation_of :password

    validates_with Validator::UniqueEmail
    validates_with Validator::StrongPassword

    def call(session)
      return false unless valid?

      create_user(session)

      user.present?
    end

  private

    def create_user(session)
      @user =
        UserRepository.new.sign_up(
          session: session,
          email: email,
          password: password,
          first_name: first_name,
          last_name: last_name
        )
    end
  end
end
