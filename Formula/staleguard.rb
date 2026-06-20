class Staleguard < Formula
  desc "Sanity-check CLAUDE.md, project docs, and code against each other for coherence drift."
  homepage "https://github.com/Arthur920/Staleguard"
  version "0.2.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Arthur920/Staleguard/releases/download/v0.2.2/staleguard-aarch64-apple-darwin.tar.xz"
      sha256 "616404e3691444f6d2d2efe1e899787f3cb240395a726436e2d13b183b7759c2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Arthur920/Staleguard/releases/download/v0.2.2/staleguard-x86_64-apple-darwin.tar.xz"
      sha256 "f5a673009f7fec15352e1b30199bfd899f00889a560b9472299f47f7346c6c24"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Arthur920/Staleguard/releases/download/v0.2.2/staleguard-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "c474fb3c790ce0584aa07d83a4c66faf5b3ff921bea2fab5febe7419dd944fa6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Arthur920/Staleguard/releases/download/v0.2.2/staleguard-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e34968a803b890f64b6ee04386035ea1f5d0d2659657c9ba7af4b504f0913fa0"
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
