class Bake < Formula
  desc "Task runner built to be tastier than `make`"
  homepage "https://github.com/trinio-labs/bake"
  version "0.4.2"
  on_macos do
    on_arm do
      url "https://github.com/trinio-labs/bake/releases/download/v0.4.2/bake-cli-aarch64-apple-darwin.tar.xz"
      sha256 "50813423477d15ad44a554cb03226862d7322860080e3633b168f2947b7f2234"
    end
    on_intel do
      url "https://github.com/trinio-labs/bake/releases/download/v0.4.2/bake-cli-x86_64-apple-darwin.tar.xz"
      sha256 "ed759cee263be67d710d50de0015ac87e9616afa2c69fb576171c08dafdbd6a0"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/trinio-labs/bake/releases/download/v0.4.2/bake-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0216dc5ee19c1841bb692ecc1b140c2f83a54f0afb8ee9bb5c94d0cda44a692a"
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
