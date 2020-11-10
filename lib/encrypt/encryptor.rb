# frozen_string_literal: true

module Encrypt
  class Encryptor

    def rules
      [
        Rules::Character,
        Rules::Digit,
        Rules::Symbol
      ]
    end

    # Rule 1. Switch all letter cases
    # Rule 2. Reverse all symbols order
    # Rule 3. For number that belongs to the mapping give the next one instead
    # Exception 1. After a symbol if the next entry is not a symbol do not apply any rule
    # Exception 2. After a symbol if the next entry is a symbol continue on Rule 2.
    def encrypt(password:, direction: :forward)
      raise Encrypt::Error.new("Bad direction [#{direction}]") unless direction
      direction = direction.to_sym
      raise Encrypt::Error.new("Bad direction [#{direction}]") unless %i[forward backward].include?(direction)

      temp_password = password.dup
      (rules + [Object.const_get("Encrypt::Rules::Mapping::#{direction.to_s.capitalize}::Map")]).each do |rule|
        temp_password = rule.call(temp_password)
      end

      Rules::Deviance.new(password).call(temp_password)
    end

    def decrypt(encrypted_password:)
      encrypt(password: encrypted_password, direction: :backward)
    end
  end
end
