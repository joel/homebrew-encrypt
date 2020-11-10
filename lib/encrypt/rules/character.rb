# frozen_string_literal: true

module Encrypt
  module Rules
    class Character
      include Base

      def call(input)
        encrypted_password = String.new
        input.chars.each do |char|
          encrypted_password << update_case(char)
        end
        encrypted_password
      end

      private 

      def update_case(char)
        return char unless char =~ /[a-zA-Z]/
        return char.downcase if char =~ /[A-Z]/
        char.upcase
      end
    end
  end
end
