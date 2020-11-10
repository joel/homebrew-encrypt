# frozen_string_literal: true

module Encrypt
  module Rules
    module Mapping
      module Forward
        class Map
          include Encrypt::Rules::Base
          include Encrypt::Rules::Mapping::Base

          private

          def map(char)
            MAPPING[MAPPING.index(char) + 1]
          end
        end
      end
    end
  end
end
