class Bake < Formula
  desc "Task runner built to be tastier than `make`"
  homepage "https://github.com/trinio-labs/bake"
  version "0.4.4"
  on_macos do
    on_arm do
      url "https://github.com/trinio-labs/bake/releases/download/v0.4.4/bake-cli-aarch64-apple-darwin.tar.xz"
      sha256 "8e5a308e675f6c02e319709f95de36805aae11885a8c00629f5973b0f1245abf"
    end
    on_intel do
      url "https://github.com/trinio-labs/bake/releases/download/v0.4.4/bake-cli-x86_64-apple-darwin.tar.xz"
      sha256 "8df3044d506563204a2e99bb614062deb73e4ed4c2342bac10e121b5c94961ca"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/trinio-labs/bake/releases/download/v0.4.4/bake-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "510c19587e16217b5aa8062ae057b6bd39276456292a2458f940f2790ae8cc70"
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
