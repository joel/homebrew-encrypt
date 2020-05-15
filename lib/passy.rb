require 'zeitwerk'
loader = Zeitwerk::Loader.for_gem
loader.setup

module Passy
  class Error < StandardError; end
end
