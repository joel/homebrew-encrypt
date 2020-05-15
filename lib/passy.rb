require "passy/version"
require "active_support/dependencies/autoload"

module Passy
  extend ActiveSupport::Autoload

  class Error < StandardError; end

  autoload :Encryptor
end
