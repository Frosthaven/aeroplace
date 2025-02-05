class Aeroplace < Formula
  desc "Helper utility for generating deterministic Aerospace application layouts at launch"
  homepage "https://github.com/Frosthaven/aeroplace"
  url "https://github.com/Frosthaven/homebrew-aeroplace/archive/refs/tags/v.0.0.5.tar.gz"

  # regenerate SHA256 with this format for your release download:
  # curl -L https://github.com/Frosthaven/aeroplace/archive/refs/tags/v0.0.2.tar.gz | shasum -a 256
  sha256 "d5558cd419c8d46bdc958064cb97f963d1ea793866414c025906ec15033512ed" 
  
  license "MIT"

  def install
    bin.install "src/run.sh" => "aeroplace"
  end

  test do
    system "false"
  end
end
