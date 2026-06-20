class StaleguardMl < Formula
  desc "Doc-drift checker with local ML layers (embeddings + NLI judge)"
  homepage "https://github.com/Arthur920/Staleguard"
  url "https://github.com/Arthur920/Staleguard/archive/refs/tags/v0.2.1.tar.gz"
  sha256 "0eb3fd0c9af1e2ffc286aef5dc3cf774ba1c3b7a886c6a75c144f9d2e8e0204b"
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
