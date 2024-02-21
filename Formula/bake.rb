class Bake < Formula
  desc "Task runner built to be tastier than Make"
  homepage "https://github.com/trinio-labs/bake"
  url "https://github.com/trinio-labs/bake/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "d4dd5498ff662fdfa9e65f83a59ab08be39b72adaa06ae9c02400a1e32c95c7a"
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
