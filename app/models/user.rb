class User < Hanami::Entity
  def authenticated?
    false
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
