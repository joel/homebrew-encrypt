# frozen_string_literal: true

module Encrypt
  module Rules
    module Base
      def self.included(base)
        base.extend(ClassMethods)
      end
      module ClassMethods
        def call(input)
          instance = new()
          instance.call(input)
        end
      end

      private

      def get_symbols(input)
        chars = input.scan(/./)
        none_symbols = []

        chars.each do |char|
          none_symbols << char if char =~ /[a-zA-Z0-9]/
        end

        chars - none_symbols
      end
    end
  end
end
