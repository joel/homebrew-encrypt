class Encrypt < Formula
  desc "Generate and decrypt password"
  homepage "https://github.com/joel/homebrew-encrypt"
  version "0.4"

  url "https://github.com/joel/homebrew-encrypt/archive/0.4.zip", :using => :curl

  def install
    bin.install "bin/encrypt"
  end
end
