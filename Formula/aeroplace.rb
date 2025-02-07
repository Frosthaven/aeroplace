class Aeroplace < Formula
  desc "A utility for generating deterministic Aerospace application layouts on launch."
  homepage "https://github.com/Frosthaven/aeroplace"
  url "https://github.com/Frosthaven/homebrew-aeroplace/archive/refs/tags/v0.0.15.tar.gz"

  # regenerate SHA256 with this format for your release download:
  # curl -L https://github.com/Frosthaven/aeroplace/archive/refs/tags/v0.0.2.tar.gz | shasum -a 256
  sha256 "a28ca989eb203cba264bc8855ff01db4993367e12ab3d57c3b2bed55790408ed"
  
  license "MIT"

  def install
    bin.install "src/run.sh" => "aeroplace"
  end

  test do
    system "false"
  end
end
