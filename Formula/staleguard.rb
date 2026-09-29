class Staleguard < Formula
  desc "Sanity-check CLAUDE.md, project docs, and code against each other for coherence drift."
  homepage "https://github.com/Arthur920/Staleguard"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Arthur920/Staleguard/releases/download/v0.4.0/staleguard-aarch64-apple-darwin.tar.xz"
      sha256 "d0aef9baf8746a8103b532091d16167c6222fff9001048367f5c86dff3085fc2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Arthur920/Staleguard/releases/download/v0.4.0/staleguard-x86_64-apple-darwin.tar.xz"
      sha256 "fa48f6a39f3e554e4a8f52eddd40325bf287f0eebd2215393c808a77439e4d10"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Arthur920/Staleguard/releases/download/v0.4.0/staleguard-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "2a459d000155804052c1aed0d8fba0235a30b87a16310e98e1c97a88aeba4645"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Arthur920/Staleguard/releases/download/v0.4.0/staleguard-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3a87c6abfc1d2bea4aca26739cc93229e88907ecac1179e8bf3451601813ddaa"
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
    if OS.mac? && Hardware::CPU.arm?
      bin.install "staleguard"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "staleguard"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "staleguard"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "staleguard"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
