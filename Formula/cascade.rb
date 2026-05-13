class Cascade < Formula
  desc "CSS generation and manipulation tool"
  homepage "https://tangled.org/samoht/cascade"
  license "ISC"
  version "20260513-a72d5df"

  on_macos do
    on_arm do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/cascade/arm64_sonoma/20260513-a72d5df.bottle.tar.gz"
      sha256 "5e6450dac219b9bacb83c58240702c61e02e3f5afc0eb986cf05207496f84a5e"
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
