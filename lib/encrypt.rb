require 'zeitwerk'
loader = Zeitwerk::Loader.for_gem
loader.setup

module Encrypt
  class Error < StandardError; end
end
