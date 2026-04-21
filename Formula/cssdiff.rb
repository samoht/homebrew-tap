class Cssdiff < Formula
  desc "Compare CSS files with structural analysis"
  homepage "https://tangled.org/samoht/cssdiff"
  license "ISC"
  version "20260421-4c8962d"

  on_macos do
    on_arm do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/cssdiff-20260421-4c8962d.arm64_sonoma.bottle.tar.gz"
      sha256 "6f277f3a532f7213de3125f4081e0369e883d5985c3ccfea1a05bccfd0e8f3a7"
    end
    on_intel do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/cssdiff-latest.sonoma.bottle.tar.gz"
      sha256 :no_check
    end
  end

  on_linux do
    url "https://homebrew-bottles.s3.fr-par.scw.cloud/cssdiff-latest.x86_64_linux.bottle.tar.gz"
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
      system "opam", "exec", "--", "dune", "build", "bin/cssdiff.exe"
      bin.install "_build/default/bin/cssdiff.exe" => "cssdiff"
    else
      bin.install "cssdiff"
    end
  end

  test do
    system bin/"cssdiff", "--help"
  end
end
