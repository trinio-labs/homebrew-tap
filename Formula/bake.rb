class Bake < Formula
  desc "Task runner built to be tastier than `make`"
  homepage "https://github.com/trinio-labs/bake"
  version "0.9.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/trinio-labs/bake/releases/download/v0.9.1/bake-cli-aarch64-apple-darwin.tar.gz"
      sha256 "81919991006ae4e22dfd74f73d134ad74242dfe5b506864af1fab2f9a035b83e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/trinio-labs/bake/releases/download/v0.9.1/bake-cli-x86_64-apple-darwin.tar.gz"
      sha256 "2d7f4f76c8fd3652251bad13ce62221728230e9e5ad980b58ba131cee39f3b06"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/trinio-labs/bake/releases/download/v0.9.1/bake-cli-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "57210bf0bd9c72bc651e1374cbdcc4e85bc3d893a7a2574cfeca540b03b3fe98"
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
