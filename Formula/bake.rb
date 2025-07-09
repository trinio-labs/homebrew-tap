class Bake < Formula
  desc "Task runner built to be tastier than `make`"
  homepage "https://github.com/trinio-labs/bake"
  version "0.8.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/trinio-labs/bake/releases/download/v0.8.1/bake-cli-aarch64-apple-darwin.tar.gz"
      sha256 "3f657c41b843625ddbc524af55fe052367c7c0126461baedc69091aa94e32613"
    end
    if Hardware::CPU.intel?
      url "https://github.com/trinio-labs/bake/releases/download/v0.8.1/bake-cli-x86_64-apple-darwin.tar.gz"
      sha256 "f9d814a3e1d980761deced69165fd5f9fc8e21959a4d5adf04f5b5dfcacea049"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/trinio-labs/bake/releases/download/v0.8.1/bake-cli-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "8dff86c6bcf38fc3e80f3e09cf0d1508ede5172508832533c702a8a339ce4089"
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
