module Validator
  class StrongPassword < ActiveModel::Validator
    def validate(record)
      return if record.password.length > 11

      record.errors.add(:password, :too_short)
    end
  end
end
