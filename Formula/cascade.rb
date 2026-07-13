class Cascade < Formula
  desc "CSS generation and manipulation tool"
  homepage "https://tangled.org/samoht/cascade"
  license "ISC"
  version "20260713-011a32398d95ad1a5fd7ffbb8dfa5fe430c1f52c+dirty"

  on_macos do
    on_arm do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/cascade/arm64_sonoma/20260713-011a32398d95ad1a5fd7ffbb8dfa5fe430c1f52c+dirty.bottle.tar.gz"
      sha256 "8f0b1cad0af5da6f8c792e1060fa2c8de8559ecb3a6e867e85e8463764aa40be"
    end
    on_intel do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/cascade-latest.sonoma.bottle.tar.gz"
      sha256 :no_check
    end
  end

  on_linux do
    url "https://homebrew-bottles.s3.fr-par.scw.cloud/cascade-latest.x86_64_linux.bottle.tar.gz"
    sha256 :no_check
  end

  head "https://tangled.org/samoht/mono.git", branch: "main"

  head do
    depends_on "ocaml" => :build
    depends_on "opam" => :build
    depends_on "dune" => :build
  end

  def install
    if build.head?
      system "opam", "init", "--disable-sandboxing", "--no-setup", "-y" unless File.exist?("#{Dir.home}/.opam")
      system "opam", "install", ".", "--deps-only", "--with-test=false", "-y", "--working-dir"
      system "opam", "exec", "--", "dune", "build", "bin/cascade_main.exe"
      bin.install "_build/default/bin/cascade_main.exe" => "cascade"
    else
      bin.install "cascade"
    end
  end

  test do
    system bin/"cascade", "--help"
  end
end
