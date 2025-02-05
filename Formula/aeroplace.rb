class Aeroplace < Formula
  desc "Helper utility for generating deterministic Aerospace application layouts at launch"
  homepage "https://github.com/Frosthaven/aeroplace"
  url "https://github.com/Frosthaven/homebrew-aeroplace/archive/refs/tags/v.0.0.5.tar.gz"

  # regenerate SHA256 with this format for your release download:
  # curl -L https://github.com/Frosthaven/aeroplace/archive/refs/tags/v0.0.2.tar.gz | shasum -a 256
  sha256 "bf63945e1e5bef31fa437170e8f6384d3fd53696f78a24ac64e3e6ac7d74c7e4" 
  
  license "MIT"

  def install
    bin.install "src/run.sh" => "aeroplace"
  end

  test do
    system "false"
  end
end
