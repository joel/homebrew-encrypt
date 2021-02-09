class Encrypt < Formula
  desc "Encode password"
  homepage "https://github.com/joel/homebrew-encrypt"
  version "0.6"

  url "https://github.com/joel/homebrew-encrypt/archive/0.6.zip", :using => :curl

  def install
    bin.install "bin/encrypt"
  end
end
