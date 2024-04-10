class Bake < Formula
  desc "Task runner built to be tastier than `make`"
  homepage "https://github.com/trinio-labs/bake"
  version "0.4.6"
  on_macos do
    on_arm do
      url "https://github.com/trinio-labs/bake/releases/download/v0.4.6/bake-cli-aarch64-apple-darwin.tar.xz"
      sha256 "86090a55b86d9e7a17b5b0259eb09d9a5beb742f0ea9f12a7018376c71354bd4"
    end
    on_intel do
      url "https://github.com/trinio-labs/bake/releases/download/v0.4.6/bake-cli-x86_64-apple-darwin.tar.xz"
      sha256 "14426e2cb840888d6be4de61d3d899bbd6f6a260c3610cf52668f381ade4053a"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/trinio-labs/bake/releases/download/v0.4.6/bake-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "38df3da23396d11c2fc96ab260350fd5508f840edeb3d5b138baa0635b1d90bc"
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
