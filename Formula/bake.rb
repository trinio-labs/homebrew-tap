class Bake < Formula
  desc "Task runner built to be tastier than `make`"
  homepage "https://github.com/trinio-labs/bake"
  version "0.3.1"
  on_macos do
    on_arm do
      url "https://github.com/trinio-labs/bake/releases/download/v0.3.1/bake-cli-aarch64-apple-darwin.tar.xz"
      sha256 "b0066a4a46e0a80598e49dc472e7012c02270f9a3a0d8fe69c9d65c5c00eed20"
    end
    on_intel do
      url "https://github.com/trinio-labs/bake/releases/download/v0.3.1/bake-cli-x86_64-apple-darwin.tar.xz"
      sha256 "61b46a81b46d5f1f22bca2a2b09419738a2b94040d43ec87a791e93c974c230f"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/trinio-labs/bake/releases/download/v0.3.1/bake-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "deaf0a6e39015cece919611b6346f1e3c41e2424490b22da9bcd9e6316dd44fa"
    end
  end
  license "Apache-2.0"

  def install
    on_macos do
      on_arm do
        bin.install "bake"
      end
    end
    on_macos do
      on_intel do
        bin.install "bake"
      end
    end
    on_linux do
      on_intel do
        bin.install "bake"
      end
    end

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install *leftover_contents unless leftover_contents.empty?
  end
end
