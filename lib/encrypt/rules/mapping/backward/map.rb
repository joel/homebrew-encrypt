# frozen_string_literal: true

module Encrypt
  module Rules
    module Mapping
      module Backward
        class Map
          include Encrypt::Rules::Base
          include Encrypt::Rules::Mapping::Base

          private
          
          def map(char)
            return '9' if char == '0'
            MAPPING[MAPPING.index(char) - 1]
          end
        end
      end
    end
  end
end
