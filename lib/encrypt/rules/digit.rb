# frozen_string_literal: true

module Encrypt
  module Rules
    class Digit
      include Base

      def call(input)
        input
      end
    end
  end
end
