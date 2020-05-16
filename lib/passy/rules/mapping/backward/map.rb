# frozen_string_literal: true

module Passy
  module Rules
    module Mapping
      module Backward
        class Map
          include Passy::Rules::Base
          include Passy::Rules::Mapping::Base

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
