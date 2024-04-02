class Bake < Formula
  desc "Task runner built to be tastier than `make`"
  homepage "https://github.com/trinio-labs/bake"
  version "0.4.3"
  on_macos do
    on_arm do
      url "https://github.com/trinio-labs/bake/releases/download/v0.4.3/bake-cli-aarch64-apple-darwin.tar.xz"
      sha256 "4c0982fa26a05dc67302d8c55699172817e4ab4f748cd5e17a4e41f288d30001"
    end
    on_intel do
      url "https://github.com/trinio-labs/bake/releases/download/v0.4.3/bake-cli-x86_64-apple-darwin.tar.xz"
      sha256 "fbf19b09f95c79180b9b89c494bd56b8d76b79e25a5b7314c31e79544f277a6f"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/trinio-labs/bake/releases/download/v0.4.3/bake-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "31c71bac4999d39601fc94b9d99c581e4da69d47a2f16bb0a399d8374db38228"
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
