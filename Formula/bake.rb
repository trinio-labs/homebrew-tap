class Bake < Formula
  desc "Task runner built to be tastier than `make`"
  homepage "https://github.com/trinio-labs/bake"
  version "0.4.0"
  on_macos do
    on_arm do
      url "https://github.com/trinio-labs/bake/releases/download/v0.4.0/bake-cli-aarch64-apple-darwin.tar.xz"
      sha256 "8dfc2ac9bed05647dfe903bcc77e23a5f03a6a31926d15178cdb9cd5d042fbc0"
    end
    on_intel do
      url "https://github.com/trinio-labs/bake/releases/download/v0.4.0/bake-cli-x86_64-apple-darwin.tar.xz"
      sha256 "9a82d966483229d15deef44e52b025f3bd6ca284728de5b12495b80d706b0465"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/trinio-labs/bake/releases/download/v0.4.0/bake-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d4fa5ec9fd972e0e32c1307bbdc293ec4abdb79cc07d433dd66011cfae5b70cb"
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
