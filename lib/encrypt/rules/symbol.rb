# frozen_string_literal: true

module Encrypt
  module Rules
    class Symbol
      include Base

      def call(input)
        symbols = get_symbols(input)
        symbols_dup = symbols.dup

        encrypted_password = String.new
        input.chars.each do |char|
          if symbols.include?(char)
            encrypted_password << symbols_dup.pop # reverse symbols
          else
            encrypted_password << char
          end
        end
        encrypted_password
      end
    end
  end
end
