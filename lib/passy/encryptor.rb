# frozen_string_literal: true

module Passy
  class Encryptor
    # Rule 1. Switch all letter cases
    # Rule 2. Reverse all symbols order
    # Rule 3. For number that belongs to the mapping give the next one instead
    # Exception 1. After a symbol if the next entry is not a symbol do not apply any rule
    # Exception 2. After a symbol if the next entry is a symbol continue on Rule 2.
    def encrypt(password:, direction: :forward)
      raise Passy::Error.new("Bad direction [#{direction}]") unless direction
      direction = direction.to_sym
      raise Passy::Error.new("Bad direction [#{direction}]") unless %i[forward backward].include?(direction)

      encrypted_password = String.new

      array = password.scan(/./)
      none_symbols = []

      array.each do |entry|
        none_symbols << entry if entry =~ /[a-zA-Z0-9]/
      end

      symbols = array - none_symbols
      copy_symbols = symbols.dup

      expection_rule = false

      index = 0
      password.chars.each do |char|
        if expection_rule
          encrypted_password << char
          expection_rule = false
        else
          case char
          when /[a-zA-Z]/
            encrypted_password << update_case(char) # switch letter cases
          when /[0-9]/
            if direction == :forward
              encrypted_password << mapping(char) # map the number if needed
            else
              encrypted_password << inversed_mapping(char) # map the number if needed
            end
          else
            encrypted_password << copy_symbols.pop # reverse symbols

            # If the next character is a symbol we do not apply the execption rule
            if index < password.length &&
              !symbols.include?(password[index + 1])

              expection_rule = true
            end

          end
        end

        index += 1
      end

      encrypted_password
    end

    def decrypt(encrypted_password:)
      encrypt(password: encrypted_password, direction: :backward)
    end

    private

    def update_case(char)
      return char.downcase if char =~ /[A-Z]/
      char.upcase
    end

    def mapping(number)
      return number unless MAPPING.include?(number)
      MAPPING[MAPPING.index(number) + 1]
    end

    def inversed_mapping(number)
      return number unless MAPPING.include?(number)
      return '9' if number == '0'
      MAPPING[MAPPING.index(number) - 1]
    end

    MAPPING = (%w[0 7 1 1 1 9 7 6].sort.uniq + ['0']).freeze
    # [0, 1, 6, 7, 9]
  end
end
