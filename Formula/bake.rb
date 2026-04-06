class Bake < Formula
  desc "Task runner built to be tastier than `make`"
  homepage "https://github.com/trinio-labs/bake"
  version "2.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/trinio-labs/bake/releases/download/v2.2.0/bake-cli-aarch64-apple-darwin.tar.gz"
      sha256 "a08e1fa621c4edd8d2c5f3f118ce8419e8f6f432195ea99f4e4dccccd7fb0485"
    end
    if Hardware::CPU.intel?
      url "https://github.com/trinio-labs/bake/releases/download/v2.2.0/bake-cli-x86_64-apple-darwin.tar.gz"
      sha256 "d19f7873fc0a7c5e7fcb308d330d631463770096a6fa8366307805dea13ddaed"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/trinio-labs/bake/releases/download/v2.2.0/bake-cli-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "c6ab01d51f4952f40be2227c7e943135753d27ed8242436519f07ea30a89dcb6"
  end
  license "Apache-2.0"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":     {},
    "x86_64-apple-darwin":      {},
    "x86_64-unknown-linux-gnu": {},
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
    bin.install "bake" if OS.mac? && Hardware::CPU.arm?
    bin.install "bake" if OS.mac? && Hardware::CPU.intel?
    bin.install "bake" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
