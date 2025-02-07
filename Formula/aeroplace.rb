class Aeroplace < Formula
  desc "A utility for generating deterministic Aerospace application layouts on launch."
  homepage "https://github.com/Frosthaven/aeroplace"
  url "https://github.com/Frosthaven/homebrew-aeroplace/archive/refs/tags/v0.0.11.tar.gz"

  # regenerate SHA256 with this format for your release download:
  # curl -L https://github.com/Frosthaven/aeroplace/archive/refs/tags/v0.0.2.tar.gz | shasum -a 256
  sha256 "557c3c0dc31d1543cd98e188b70e2eac194b2169f5a84ed74edd6ccfecfc4a34"
  
  license "MIT"

  def install
    bin.install "src/run.sh" => "aeroplace"
  end

  test do
    system "false"
  end
end
