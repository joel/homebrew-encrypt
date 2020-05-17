#!/usr/bin/env ruby

require_relative '../lib/passy.rb'

require 'pry'

# Convert a password stored into the clipboard
# bin/encrypt --clipboard

# bin/encrypt --password '1%195bDf!g'
# 6!105BdF%g

# Get back the password from the clipboard
# bin/encrypt --clipboard --direction 'backward'
# 1%195bDf!g

encryptor = Passy::Ui.new
password = encryptor.convert

puts password
