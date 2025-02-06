class Aeroplace < Formula
  desc "A utility for generating deterministic Aerospace application layouts on launch."
  homepage "https://github.com/Frosthaven/aeroplace"
  url "https://github.com/Frosthaven/homebrew-aeroplace/archive/refs/tags/v0.0.10.tar.gz"

  # regenerate SHA256 with this format for your release download:
  # curl -L https://github.com/Frosthaven/aeroplace/archive/refs/tags/v0.0.2.tar.gz | shasum -a 256
  sha256 "9833730461009178ae02cd3d753152749e240311f5d948af111bf58b570879e8"
  
  license "MIT"

  def install
    bin.install "src/run.sh" => "aeroplace"
  end

  test do
    system "false"
  end
end
