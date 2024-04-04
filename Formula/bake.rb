class Bake < Formula
  desc "Task runner built to be tastier than `make`"
  homepage "https://github.com/trinio-labs/bake"
  version "0.4.5"
  on_macos do
    on_arm do
      url "https://github.com/trinio-labs/bake/releases/download/v0.4.5/bake-cli-aarch64-apple-darwin.tar.xz"
      sha256 "dae105fda31945a8544a9d85cd03a5beb49703ada082292663c54277b01bbad9"
    end
    on_intel do
      url "https://github.com/trinio-labs/bake/releases/download/v0.4.5/bake-cli-x86_64-apple-darwin.tar.xz"
      sha256 "10dda512fa35eb54bc6ff40aa768d57dda06906831b7bf78432a86eca6baa6a1"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/trinio-labs/bake/releases/download/v0.4.5/bake-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "4e4a2e1cb3dd200de036fc9c8862157ac00d66b71105b1c81779c6c44ea0d34d"
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
