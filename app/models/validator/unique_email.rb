module Validator
  class UniqueEmail < ActiveModel::Validator
    def validate(record)
      return unless UserRepository.new.email_exists?(record.email)

      record.errors.add(:email, :duplicate)
    end
  end
end
