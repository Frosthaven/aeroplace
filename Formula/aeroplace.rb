# Documentation: https://github.com/frosthaven/aeroplace

class Aerospace < Formula
  desc "Helper utility for generating deterministic Aurospace application layouts on launch"
  homepage "https://github.com/frosthaven/aeroplace"
  url "https://github.com/frosthaven/aeroplace"
  license "MIT"

  depends_on "aerospace"

  def install
    bin.install "src/run.sh" => "aeroplace"
  end
end

