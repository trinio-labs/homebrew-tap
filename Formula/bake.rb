class Bake < Formula
  desc "Task runner built to be tastier than `make`"
  homepage "https://github.com/trinio-labs/bake"
  version "0.6.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/trinio-labs/bake/releases/download/v0.6.1/bake-cli-aarch64-apple-darwin.tar.gz"
      sha256 "48abcdaced9937fcf0c07130a285742a8ed5949d55bb8f8a6e99e7efa60ac514"
    end
    if Hardware::CPU.intel?
      url "https://github.com/trinio-labs/bake/releases/download/v0.6.1/bake-cli-x86_64-apple-darwin.tar.gz"
      sha256 "1e5946c1e242d6efdfaecde9bf4ece29d59b2a935e6e5f84f957cc857f0ab409"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/trinio-labs/bake/releases/download/v0.6.1/bake-cli-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "7ce5018fafb9bcf718dc874b543aaab5e565165b0e951a9e29eabfd1d2228346"
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
