class StaleguardMl < Formula
  desc "Doc-drift checker with local ML layers (embeddings + NLI judge)"
  homepage "https://github.com/Arthur920/Staleguard"
  url "https://github.com/Arthur920/Staleguard/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "e4e6c3eb9a7f6ebe14a00295c49e8fa5b0f2e10d9e8098f67ba2c64446642b9c"
  license "MIT"
  version "0.1.1"

  depends_on "rust" => :build

  conflicts_with "staleguard", because: "both install a `staleguard` binary"

  def install
    system "cargo", "install", "--features", "ml", *std_cargo_args
  end

  test do
    assert_match "staleguard", shell_output("#{bin}/staleguard --version")
  end
end
