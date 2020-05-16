# frozen_string_literal: true

module Passy
  module Rules
    module Mapping
      module Base

        def call(input)
          encrypted_password = String.new
          input.chars.each do |char|
            encrypted_password << mapping(char)
          end
          encrypted_password
        end

        private

        def mapping(char)
          return char unless char =~ /[0-9]/
          return char unless MAPPING.include?(char)
          map(char)
        end

        MAPPING = (%w[0 7 1 1 1 9 7 6].sort.uniq + ['0']).freeze
      end
    end
  end
end
