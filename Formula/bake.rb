class Bake < Formula
  desc "Task runner built to be tastier than `make`"
  homepage "https://github.com/trinio-labs/bake"
  version "2.0.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/trinio-labs/bake/releases/download/v2.0.3/bake-cli-aarch64-apple-darwin.tar.gz"
      sha256 "d595a4eba58e8fedd5c77dd7e094172c2938414d6a18605f5ece4deca2908796"
    end
    if Hardware::CPU.intel?
      url "https://github.com/trinio-labs/bake/releases/download/v2.0.3/bake-cli-x86_64-apple-darwin.tar.gz"
      sha256 "f2d5eeefe5e5102bc96bae774381d1bed9d9dc15476996245976891cb83752fb"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
      url "https://github.com/trinio-labs/bake/releases/download/v2.0.3/bake-cli-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "465f8e582c17b6bdb607f3ebf1fe064e3d8d9246991193e8b394249442b4fc92"
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
