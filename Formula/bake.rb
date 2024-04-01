class Bake < Formula
  desc "Task runner built to be tastier than `make`"
  homepage "https://github.com/trinio-labs/bake"
  version "0.4.1"
  on_macos do
    on_arm do
      url "https://github.com/trinio-labs/bake/releases/download/v0.4.1/bake-cli-aarch64-apple-darwin.tar.xz"
      sha256 "ffe7c1e63101d4df7e137a63502ecb4a5fa421083fdf363e2346e7c453d5b486"
    end
    on_intel do
      url "https://github.com/trinio-labs/bake/releases/download/v0.4.1/bake-cli-x86_64-apple-darwin.tar.xz"
      sha256 "30751821f00560f5e251d9958f6298f9db4f80a021b03062fe30dd89f0a7b9e8"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/trinio-labs/bake/releases/download/v0.4.1/bake-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "03767118bf161c95fba004e284ba5e849cb748c092de0a66aff16120f310a0cc"
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
