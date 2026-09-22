class Bake < Formula
  desc "Task runner built to be tastier than `make`"
  homepage "https://github.com/trinio-labs/bake"
  version "2.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/trinio-labs/bake/releases/download/v2.3.0/bake-cli-aarch64-apple-darwin.tar.gz"
      sha256 "9157a88b306b70a77a6a4e2152ff05946bc8e3292047415687bd44ca258a8a06"
    end
    if Hardware::CPU.intel?
      url "https://github.com/trinio-labs/bake/releases/download/v2.3.0/bake-cli-x86_64-apple-darwin.tar.gz"
      sha256 "5882252f6014b4875433d1b938f0f2118a6b839a91d72549731019d85947779f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/trinio-labs/bake/releases/download/v2.3.0/bake-cli-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "439932e0c5a70f588f71d3363611fad9911aeda9c5c3bbaa6bf10b19321dfec3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/trinio-labs/bake/releases/download/v2.3.0/bake-cli-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3b02724006988bdb271f5e0df9580c63ebaf85f823c839890ccb2efef5180483"
    end
  end
  license "Apache-2.0"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
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
      bin.install "bake"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "bake"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "bake"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "bake"
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
