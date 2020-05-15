#!/usr/bin/env ruby

require_relative '../lib/passy.rb'

require 'pry'

encryptor = Passy::Ui.new
encryptor.convert
