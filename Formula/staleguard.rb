class Staleguard < Formula
  desc "Sanity-check CLAUDE.md, project docs, and code against each other for coherence drift."
  homepage "https://github.com/Arthur920/Staleguard"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Arthur920/Staleguard/releases/download/v0.1.1/staleguard-aarch64-apple-darwin.tar.xz"
      sha256 "c1d7c94aa929d31d3302284410cedb3796792788038548c4ade4d782c40ca983"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Arthur920/Staleguard/releases/download/v0.1.1/staleguard-x86_64-apple-darwin.tar.xz"
      sha256 "cf10273f5fa5e52e5fac61d7d1162d67eff0616e09540a63ef1795c4cbcafecf"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Arthur920/Staleguard/releases/download/v0.1.1/staleguard-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "d88059e06678f11f979d2dc20d86b9f933d3da586c9e867e2d26c654ad6dd26d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Arthur920/Staleguard/releases/download/v0.1.1/staleguard-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1b6369a8f841bf2752c661d25fa12001227e036b57491fff5894e21668464df3"
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
