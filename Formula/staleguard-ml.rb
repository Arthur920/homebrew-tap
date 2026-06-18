class StaleguardMl < Formula
  desc "Doc-drift checker with local ML layers (embeddings + NLI judge)"
  homepage "https://github.com/Arthur920/Staleguard"
  url "https://github.com/Arthur920/Staleguard/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "16248c4bb0b23336cb4e3e37be4efec23356f572596092c5c5562f52e3233297"
  license "MIT"

  depends_on "rust" => :build

  conflicts_with "staleguard", because: "both install a `staleguard` binary"

  def install
    system "cargo", "install", "--features", "ml", *std_cargo_args
  end

  test do
    assert_match "staleguard", shell_output("#{bin}/staleguard --version")
  end
end
