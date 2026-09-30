class Staleguard < Formula
  desc "Sanity-check CLAUDE.md, project docs, and code against each other for coherence drift."
  homepage "https://github.com/Arthur920/Staleguard"
  version "0.4.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Arthur920/Staleguard/releases/download/v0.4.1/staleguard-aarch64-apple-darwin.tar.xz"
      sha256 "98592281db5b0ed59d72826a00411d8c2d4bb7ca581dac26617fb4d28e424489"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Arthur920/Staleguard/releases/download/v0.4.1/staleguard-x86_64-apple-darwin.tar.xz"
      sha256 "ebca1e22cf2749ce1c6fcc222c3185a0a8d547eabf026d29cc0321185e93d20a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Arthur920/Staleguard/releases/download/v0.4.1/staleguard-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "77cda8aa123eb6329e622402b9784dfb3bf3b88ea0773cad78996e5ad2e83427"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Arthur920/Staleguard/releases/download/v0.4.1/staleguard-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c8745443e3561503732c93b8aa10a2642abc8bcf40c6352654efde4a80b24e5f"
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
