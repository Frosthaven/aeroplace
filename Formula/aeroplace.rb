class Aeroplace < Formula
  desc "Helper utility for generating deterministic Aerospace application layouts at launch"
  homepage "https://github.com/Frosthaven/aeroplace"
  url "https://github.com/Frosthaven/homebrew-aeroplace/archive/refs/tags/v.0.0.6.tar.gz"

  # regenerate SHA256 with this format for your release download:
  # curl -L https://github.com/Frosthaven/aeroplace/archive/refs/tags/v0.0.2.tar.gz | shasum -a 256
  sha256 "78441d26bfd0f79fbc2550ff75ab2d7bb06aaf1b5d7280371ada7a3e61273490" 
  
  license "MIT"

  def install
    bin.install "src/run.sh" => "aeroplace"
  end

  test do
    system "false"
  end
end
