class Bake < Formula
  desc "Task runner built to be tastier than `make`"
  homepage "https://github.com/trinio-labs/bake"
  version "0.4.8"
  on_macos do
    on_arm do
      url "https://github.com/trinio-labs/bake/releases/download/v0.4.8/bake-cli-aarch64-apple-darwin.tar.xz"
      sha256 "b2d5ac919928907ce425e87eaae4d64238ae9beb29d0524941de6a15ed789429"
    end
    on_intel do
      url "https://github.com/trinio-labs/bake/releases/download/v0.4.8/bake-cli-x86_64-apple-darwin.tar.xz"
      sha256 "58004b8e14c4c296af8eecf967d255c70fe790fe29e632223ee454b067941a4c"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/trinio-labs/bake/releases/download/v0.4.8/bake-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e5cde433a5aaed2aff6e3fc83935fb71d0874f11dbb423223d09ea2603a4191d"
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
