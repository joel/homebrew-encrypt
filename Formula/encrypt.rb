class Encrypt < Formula
  desc "Encode password"
  homepage "https://github.com/joel/homebrew-encrypt"
  version "0.7"

  url "https://github.com/joel/homebrew-encrypt/archive/0.7.zip", :using => :curl

  def install
    bin.install "bin/encrypt"
  end
end
