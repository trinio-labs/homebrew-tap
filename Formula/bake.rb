class Bake < Formula
  desc "Task runner built to be tastier than `make`"
  homepage "https://github.com/trinio-labs/bake"
  version "2.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/trinio-labs/bake/releases/download/v2.2.0/bake-cli-aarch64-apple-darwin.tar.gz"
      sha256 "0372018cc5e29e9992245a62b6d268af3ef632a8afd9d02668adb61139383cb8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/trinio-labs/bake/releases/download/v2.2.0/bake-cli-x86_64-apple-darwin.tar.gz"
      sha256 "6fc7399c03ece6a8f538c730117d97f6e6c5c264e880671bc6798f8aa9b9f44b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/trinio-labs/bake/releases/download/v2.2.0/bake-cli-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b36755a376169236a3bc739227726726116240a6395c72570e76ac752ddff0e7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/trinio-labs/bake/releases/download/v2.2.0/bake-cli-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "754d7a915e30cfec66d8b612fb7e3d4b0ffb24b192eb5192e0cf8d6096693211"
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
    bin.install "bake" if OS.mac? && Hardware::CPU.arm?
    bin.install "bake" if OS.mac? && Hardware::CPU.intel?
    bin.install "bake" if OS.linux? && Hardware::CPU.arm?
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
