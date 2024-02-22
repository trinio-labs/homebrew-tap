class Bake < Formula
  desc "Task runner built to be tastier than `make`"
  homepage "https://github.com/trinio-labs/bake"
  version "0.1.2"
  on_macos do
    on_arm do
      url "https://github.com/trinio-labs/bake/releases/download/v0.1.2/bake-cli-aarch64-apple-darwin.tar.xz"
      sha256 "220c02270359d156af03a0175c85ab0a0d1ee9b54bc2d45d16bcdc979f67ded9"
    end
    on_intel do
      url "https://github.com/trinio-labs/bake/releases/download/v0.1.2/bake-cli-x86_64-apple-darwin.tar.xz"
      sha256 "1b6e2c17ddffa35b5344f7988214101059a40eb8a645152af054ef63908ff173"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/trinio-labs/bake/releases/download/v0.1.2/bake-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f91015f9b2d074286ff76ccc1ec96c564149bdee138604aa6b84e6899402ce38"
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
