class Bake < Formula
  desc "Task runner built to be tastier than Make"
  homepage "https://github.com/trinio-labs/bake"
  url "https://github.com/trinio-labs/bake/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "dd5f5e9979fc632ece83f5efeb43d5a6f60117834cf8349e9728efb60df79ccc"
  license "Apache-2.0"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    bake_yml = <<-EOS
      name: test
    EOS
    foo_yml = <<-EOS
      name: foo
      recipes:
        test:
          run: echo "Test successful"
    EOS
    (testpath/"bake.yml").write(bake_yml)
    (testpath/"foo/cookbook.yml").write(foo_yml)

    system ("#{bin}/bake foo:test")

    assert_match "Test successful", (testpath/".bake/logs/foo.test.log").read
  end
end
