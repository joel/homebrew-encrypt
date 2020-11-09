class Encrypt < Formula
  desc "Generate and decrypt password"
  homepage "https://github.com/joel/homebrew-encrypt"
  version "0.2"

  url "https://github.com/joel/homebrew-encrypt/archive/main.zip", :using => :curl

  def install
    bin.install "bin/encrypt"
  end
end
