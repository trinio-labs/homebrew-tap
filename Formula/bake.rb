class Bake < Formula
  desc "Task runner built to be tastier than `make`"
  homepage "https://github.com/trinio-labs/bake"
  version "0.2.0"
  on_macos do
    on_arm do
      url "https://github.com/trinio-labs/bake/releases/download/v0.2.0/bake-cli-aarch64-apple-darwin.tar.xz"
      sha256 "e359583bb926983d6a0c63320c2037f7d55b4d6cbd32fb7787bcf55e53512970"
    end
    on_intel do
      url "https://github.com/trinio-labs/bake/releases/download/v0.2.0/bake-cli-x86_64-apple-darwin.tar.xz"
      sha256 "65cdcbba84e95f5084a3e5979be138f027e398e50731d25431f55ac649e4963b"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/trinio-labs/bake/releases/download/v0.2.0/bake-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "5ad56a26f1b1b7b1d161e60b3c14a64ad080f3a22c8c112933f28fb02a96cb11"
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
