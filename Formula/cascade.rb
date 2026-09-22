class Cascade < Formula
  desc "CSS formatter, minifier, inliner, and structural diff tool"
  homepage "https://tangled.org/samoht/cascade"
  license "ISC"
  url "https://tangled.org/samoht/mono.git", using: :git, branch: "main"
  version "1.2.0"

  bottle do
    root_url "https://homebrew-bottles.s3.fr-par.scw.cloud/cascade"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "470748462b9edeaa49a504f19f3dcb6a96f38b4e28490d61073cce69361bce9b"
  end

  head "https://tangled.org/samoht/mono.git", branch: "main"

  depends_on "ocaml" => :build
  depends_on "opam" => :build
  depends_on "dune" => :build

  def install
    system "opam", "init", "--disable-sandboxing", "--no-setup", "-y" unless File.exist?("#{Dir.home}/.opam")
    system "opam", "install", ".", "--deps-only", "-y", "--working-dir"
    system "opam", "exec", "--", "dune", "build", "bin/main.exe"
    bin.install "_build/default/bin/main.exe" => "cascade"
  end

  test do
    system bin/"cascade", "--help"
  end
end
