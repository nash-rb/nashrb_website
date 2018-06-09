class User < ApplicationRecord
  has_secure_password

  def mark_as_authenticated
    @authenticated = true
  end

  def authenticated?
    @authenticated
  end

  Guest = Naught.build do |config|
    config.mimic User

    def first_name
      "Honored Guest"
    end

    def full_name
      "Honored Guest"
    end

    def authenticated?
      false
    end
  end
end
