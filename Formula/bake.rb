class Bake < Formula
  desc "Task runner built to be tastier than `make`"
  homepage "https://github.com/trinio-labs/bake"
  version "0.3.0"
  on_macos do
    on_arm do
      url "https://github.com/trinio-labs/bake/releases/download/v0.3.0/bake-cli-aarch64-apple-darwin.tar.xz"
      sha256 "b2fb55cb7f533fc8e32a7055784d4264508b23b5e788d2956d8f3ffa064a39fb"
    end
    on_intel do
      url "https://github.com/trinio-labs/bake/releases/download/v0.3.0/bake-cli-x86_64-apple-darwin.tar.xz"
      sha256 "ec0cda270eddcf6bc6d21c532f16ff8ecd348ffc4bd775f86327d28f26d8bb59"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/trinio-labs/bake/releases/download/v0.3.0/bake-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ad46c9201a7a6f2f274fecd43e52d91319e29bc47e337464d25a4b699b10db84"
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
