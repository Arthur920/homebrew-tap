class Staleguard < Formula
  desc "Sanity-check CLAUDE.md, project docs, and code against each other for coherence drift."
  homepage "https://github.com/Arthur920/Staleguard"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Arthur920/Staleguard/releases/download/v0.5.0/staleguard-aarch64-apple-darwin.tar.xz"
      sha256 "6bb8cbd58831b4888745781f7293c7d66000df0e1eb10b61bf8cd27a6e83a4f0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Arthur920/Staleguard/releases/download/v0.5.0/staleguard-x86_64-apple-darwin.tar.xz"
      sha256 "17327648c2ac56ee34c0beef058603feb3c6d7c54b32bf36c7d8ddd66ee469f0"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Arthur920/Staleguard/releases/download/v0.5.0/staleguard-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "80f3cabff5e6f76f96f3b34c6d81a7e96cf87ec6cadf9585d49fc47d3bbf5531"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Arthur920/Staleguard/releases/download/v0.5.0/staleguard-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "914cd989c2f14fec21650bcf9897bb1b00428c5e1c06a22db1f7559c02ce8572"
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
