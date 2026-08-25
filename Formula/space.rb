class Space < Formula
  desc "SpaceOS runtime and CLI"
  homepage "https://tangled.org/parsimoni/space"
  license "ISC"
  url "https://tangled.org/parsimoni/mono.git", using: :git, branch: "main"
  version "0.1.0"

  bottle do
    root_url "https://homebrew-bottles.s3.fr-par.scw.cloud/space"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "4f4ef26038a051bccd2c2dd9ce01f23bd6f7d2ac968009d70cd10daf3294586a"
  end

  head "https://tangled.org/parsimoni/mono.git", branch: "main"

  depends_on "ocaml" => :build
  depends_on "opam" => :build
  depends_on "dune" => :build

  def install
    system "opam", "init", "--disable-sandboxing", "--no-setup", "-y" unless File.exist?("#{Dir.home}/.opam")
    system "opam", "install", ".", "--deps-only", "-y", "--working-dir"
    system "opam", "exec", "--", "dune", "build", "space/bin/main.exe"
    bin.install "_build/default/space/bin/main.exe" => "space"
  end

  test do
    system bin/"space", "--help"
  end
end
