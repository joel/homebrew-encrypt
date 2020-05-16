# frozen_string_literal: true

module Passy
  module Rules
    class Deviance
      include Base

      def initialize(password)
        @password = password
      end

      def call(input)
        symbols = get_symbols(input)

        encrypted_password = String.new

        index = 0
        expection_rule = false

        input.chars.each do |char|
          if expection_rule
            encrypted_password << password[index]
            expection_rule = false
          else
            encrypted_password << char
            if symbols.include?(char)
              expection_rule = true
            end
          end

          index += 1
        end

        encrypted_password
      end

      private

      attr_reader :password
    end
  end
end
