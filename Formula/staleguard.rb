class Staleguard < Formula
  desc "Sanity-check CLAUDE.md, project docs, and code against each other for coherence drift."
  homepage "https://github.com/Arthur920/Staleguard"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Arthur920/Staleguard/releases/download/v0.3.0/staleguard-aarch64-apple-darwin.tar.xz"
      sha256 "8cbad5adb95624652517b32b4369ba5775588c2c6465f1a059da85b8e2378826"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Arthur920/Staleguard/releases/download/v0.3.0/staleguard-x86_64-apple-darwin.tar.xz"
      sha256 "79c72a9ffd4633cf10d62dd3403a4ec36b431d2d45f36504fb69c82b6c8da2df"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Arthur920/Staleguard/releases/download/v0.3.0/staleguard-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3c164efbf4bc36bf889c830522e91a9091a78c978d34780b3b28e3bb6e44ed82"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Arthur920/Staleguard/releases/download/v0.3.0/staleguard-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "9bb9696a47a7ad1431c57caa63a7279db736209623632477d22e8ddc6b36aaa9"
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
