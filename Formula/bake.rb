class Bake < Formula
  desc "Task runner built to be tastier than `make`"
  homepage "https://github.com/trinio-labs/bake"
  version "1.0.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/trinio-labs/bake/releases/download/v1.0.1/bake-cli-aarch64-apple-darwin.tar.gz"
      sha256 "8d2b0de03764f4d93bf65a269d2aab87a5a7858d40601892d33f76da647fcd60"
    end
    if Hardware::CPU.intel?
      url "https://github.com/trinio-labs/bake/releases/download/v1.0.1/bake-cli-x86_64-apple-darwin.tar.gz"
      sha256 "e5bfa2fa8159718868dab3e12b4e96ffc4b5a7f4efadd42a1aedc3a418c9a3bf"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/trinio-labs/bake/releases/download/v1.0.1/bake-cli-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "1538aa76a4e79ba5d962783f72f8af844434b0bb4089be30b07d18458486ef22"
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
