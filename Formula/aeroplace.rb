class Aeroplace < Formula
  desc "Helper utility for generating deterministic Aerospace application layouts at launch"
  homepage "https://github.com/Frosthaven/aeroplace"
  url "https://github.com/Frosthaven/aeroplace/archive/refs/tags/v0.0.2.tar.gz"

  # regenerate SHA256 with this format for your release download:
  # curl -L https://github.com/Frosthaven/aeroplace/archive/refs/tags/v0.0.2.tar.gz | shasum -a 256
  sha256 "6b2066319823a01bad845d01b8fc4570f7bcd314492dd99974596bd44ccd0f1b" 
  
  license "MIT"

  depends_on "aerospace"

  def install
    bin.install "src/run.sh" => "aeroplace"
  end

  test do
    system "false"
  end
end
