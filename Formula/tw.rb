class Tw < Formula
  desc "Type-safe Tailwind CSS v4 in OCaml"
  homepage "https://tangled.org/samoht/tw"
  license "ISC"
  version "1.0.0"

  on_macos do
    on_arm do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/tw/arm64_sonoma/1.0.0.bottle.tar.gz"
      sha256 "c367d557255e374ed6eb5969e5862ab07865b0d4779d052f06174b79d03f792b"
    end
    on_intel do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/tw/sonoma/latest.bottle.tar.gz"
      sha256 :no_check
    end
  end

  on_linux do
    url "https://homebrew-bottles.s3.fr-par.scw.cloud/tw/x86_64_linux/latest.bottle.tar.gz"
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
      system "opam", "exec", "--", "dune", "build", "bin/main.exe"
      bin.install "_build/default/bin/main.exe" => "tw"
    else
      bin.install "tw"
    end
  end

  test do
    system bin/"tw", "--help"
  end
end
