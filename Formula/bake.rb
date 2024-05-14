class Bake < Formula
  desc "Task runner built to be tastier than `make`"
  homepage "https://github.com/trinio-labs/bake"
  version "0.4.7"
  on_macos do
    on_arm do
      url "https://github.com/trinio-labs/bake/releases/download/v0.4.7/bake-cli-aarch64-apple-darwin.tar.xz"
      sha256 "48bbcec462aa3cdc0be4f1f331448b946e82edf5ca5486f084bb93d5ea20ecfb"
    end
    on_intel do
      url "https://github.com/trinio-labs/bake/releases/download/v0.4.7/bake-cli-x86_64-apple-darwin.tar.xz"
      sha256 "469a9b67652581d8a53c2d784a4e59ef12fe0622a0074cfb6669d11b9a7e9d33"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/trinio-labs/bake/releases/download/v0.4.7/bake-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "9ff9c31a483680850377e26af46445d3b8479e8b714b7092b1294979cee37c70"
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
