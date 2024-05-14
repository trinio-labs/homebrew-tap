class Bake < Formula
  desc "Task runner built to be tastier than `make`"
  homepage "https://github.com/trinio-labs/bake"
  version "0.4.7"
  on_macos do
    on_arm do
      url "https://github.com/trinio-labs/bake/releases/download/v0.4.7/bake-cli-aarch64-apple-darwin.tar.xz"
      sha256 "ade8dd5283b86f5f47dfd4e6cbce18f5d5503dc47ef61591f2466516c1225985"
    end
    on_intel do
      url "https://github.com/trinio-labs/bake/releases/download/v0.4.7/bake-cli-x86_64-apple-darwin.tar.xz"
      sha256 "547c8c619a3165da8df9a13a63b539f192f68ab1f6a76888b750c10608f01e05"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/trinio-labs/bake/releases/download/v0.4.7/bake-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a23976e2758f0a0e3f6d260b0e5846a459b8250c5ae3b59764171d50b2785e9d"
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
