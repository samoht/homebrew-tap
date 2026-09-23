class Tw < Formula
  desc "Type-safe Tailwind CSS v4 in OCaml"
  homepage "https://tangled.org/samoht/tw"
  license "ISC"
  url "https://tangled.org/samoht/mono.git", using: :git, branch: "main"
  version "1.1.0"

  bottle do
    root_url "https://homebrew-bottles.s3.fr-par.scw.cloud/tw"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "287b4090dcb9910c6642268584e87b116d2ed793fced762381b97203ea0d88ab"
  end

  head "https://tangled.org/samoht/mono.git", branch: "main"

  depends_on "ocaml" => :build
  depends_on "opam" => :build
  depends_on "dune" => :build

  def install
    system "opam", "init", "--disable-sandboxing", "--no-setup", "-y" unless File.exist?("#{Dir.home}/.opam")
    system "opam", "install", ".", "--deps-only", "-y", "--working-dir"
    system "opam", "exec", "--", "dune", "build", "bin/main.exe"
    bin.install "_build/default/bin/main.exe" => "tw"
  end

  test do
    system bin/"tw", "--help"
  end
end
