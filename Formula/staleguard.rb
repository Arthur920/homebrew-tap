class Staleguard < Formula
  desc "Sanity-check CLAUDE.md, project docs, and code against each other for coherence drift."
  homepage "https://github.com/Arthur920/Staleguard"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Arthur920/Staleguard/releases/download/v0.2.0/staleguard-aarch64-apple-darwin.tar.xz"
      sha256 "76fa8edb2576f1a9b4ec000b9939f642a6d785eab02892c6545cc57b60f3c4ba"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Arthur920/Staleguard/releases/download/v0.2.0/staleguard-x86_64-apple-darwin.tar.xz"
      sha256 "661529cb93f638a61739e31ca4822625b270fb58c63d2cafd0cd54434dd3238d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Arthur920/Staleguard/releases/download/v0.2.0/staleguard-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "36fde3c8bc7cd9e6d9036d1f87e069279d589dd7463a2d001532279d651950a0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Arthur920/Staleguard/releases/download/v0.2.0/staleguard-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "49bb85b31bcee3783c850a09b396b92f1a1e40f6fb664874b15929ef11093709"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "staleguard" if OS.mac? && Hardware::CPU.arm?
    bin.install "staleguard" if OS.mac? && Hardware::CPU.intel?
    bin.install "staleguard" if OS.linux? && Hardware::CPU.arm?
    bin.install "staleguard" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
