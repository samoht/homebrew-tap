class Tw < Formula
  desc "Type-safe Tailwind CSS v4 in OCaml"
  homepage "https://tangled.org/samoht/tw"
  license "ISC"
  url "https://tangled.org/samoht/mono.git", using: :git, branch: "main"
  version "1.1.0"

  bottle do
    root_url "https://homebrew-bottles.s3.fr-par.scw.cloud/tw"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "6663e66edcfe84de045a69019b584fe4f3e0aabd65b6c09bd71ca5c881dae401"
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
