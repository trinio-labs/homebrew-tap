class Bake < Formula
  desc "Task runner built to be tastier than `make`"
  homepage "https://github.com/trinio-labs/bake"
  version "0.4.7"
  on_macos do
    on_arm do
      url "https://github.com/trinio-labs/bake/releases/download/v0.4.7/bake-cli-aarch64-apple-darwin.tar.xz"
      sha256 "65b93dc1d36dcb6a41d57e370ed8be540a1ac697980e4265a1a9014a0f70fb9d"
    end
    on_intel do
      url "https://github.com/trinio-labs/bake/releases/download/v0.4.7/bake-cli-x86_64-apple-darwin.tar.xz"
      sha256 "91496ed8e331d002bd43ddcf64ac48e758d28d32344dc3b4641f8765a707ce2a"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/trinio-labs/bake/releases/download/v0.4.7/bake-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f516b7e71d73e4b4466a0b06266ca4e57833acd0fc0f4586d0bdd4e9ef7699bb"
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
