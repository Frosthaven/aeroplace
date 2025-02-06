class Aeroplace < Formula
  desc "A utility for generating deterministic Aerospace application layouts on launch."
  homepage "https://github.com/Frosthaven/aeroplace"
  url "https://github.com/Frosthaven/homebrew-aeroplace/archive/refs/tags/v0.0.9.tar.gz"

  # regenerate SHA256 with this format for your release download:
  # curl -L https://github.com/Frosthaven/aeroplace/archive/refs/tags/v0.0.2.tar.gz | shasum -a 256
  sha256 "d5430f1f4dd758b4274bf80964b5e5eaeb0cce16f0b619fc91894d6730f9f8f3"
  
  license "MIT"

  def install
    bin.install "src/run.sh" => "aeroplace"
  end

  test do
    system "false"
  end
end
