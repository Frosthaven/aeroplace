class Aeroplace < Formula
  desc "Helper utility for generating deterministic Aerospace application layouts at launch"
  homepage "https://github.com/Frosthaven/aeroplace"
  url "https://github.com/Frosthaven/aeroplace/archive/refs/tags/v0.0.2.zip"

  # regenerate SHA256 with this format for your release download:
  # curl -L https://github.com/Frosthaven/aeroplace/archive/refs/tags/v0.0.2.zip | shasum -a 256
  sha256 "aadf40cb211e2afa250580096cc0804fcebdfb73b8119ddbc75147a5eebae18e"
  
  license "MIT"

  depends_on "aerospace"

  def install
    bin.install "src/run.sh" => "aeroplace"
  end

  test do
    system "false"
  end
end
