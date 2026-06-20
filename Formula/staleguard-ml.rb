class StaleguardMl < Formula
  desc "Doc-drift checker with local ML layers (embeddings + NLI judge)"
  homepage "https://github.com/Arthur920/Staleguard"
  url "https://github.com/Arthur920/Staleguard/archive/refs/tags/v0.2.2.tar.gz"
  sha256 "f1007ed2973e9ada77e21cb816130db37343589f643d445cb555f2199fb1454e"
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
