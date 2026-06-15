class Staleguard < Formula
  desc "Sanity-check CLAUDE.md, project docs, and code against each other for coherence drift."
  homepage "https://github.com/Arthur920/Staleguard"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Arthur920/Staleguard/releases/download/v0.1.2/staleguard-aarch64-apple-darwin.tar.xz"
      sha256 "74e322c183982313e6066b7d724199339edebbbeb175ec7379626d5b2e46ad69"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Arthur920/Staleguard/releases/download/v0.1.2/staleguard-x86_64-apple-darwin.tar.xz"
      sha256 "8dbf34bc14ef637b65cd865fdf2f00c4fd6799aaf30497449c5f9c1c24d03a7d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Arthur920/Staleguard/releases/download/v0.1.2/staleguard-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "bdc11b9eebe8588c9f3145603ff86da8240788a085e06842cae60f0012d308f6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Arthur920/Staleguard/releases/download/v0.1.2/staleguard-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f0bfe9312062193cb5d9a398dad6ece4607b951c0affad2b11c0af13cb7a86fb"
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
