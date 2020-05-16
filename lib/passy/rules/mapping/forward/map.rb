# frozen_string_literal: true

module Passy
  module Rules
    module Mapping
      module Forward
        class Map
          include Passy::Rules::Base
          include Passy::Rules::Mapping::Base

          private

          def map(char)
            MAPPING[MAPPING.index(char) + 1]
          end
        end
      end
    end
  end
end
