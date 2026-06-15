class StaleguardMl < Formula
  desc "Doc-drift checker with local ML layers (embeddings + NLI judge)"
  homepage "https://github.com/Arthur920/Staleguard"
  url "https://github.com/Arthur920/Staleguard/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "e4960a33b67bc5376910b03fe00cdf10d36eae9c8ed3f9bd43ea105b99ca5862"
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
