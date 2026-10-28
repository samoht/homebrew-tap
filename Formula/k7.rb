class K7 < Formula
  desc "Record terminal programs, cram tests and VHS tapes as animated SVG"
  homepage "https://github.com/samoht/ocaml-k7"
  license "ISC"
  url "https://github.com/samoht/ocaml-k7.git", using: :git, branch: "main"
  version "0.9.0"

  bottle do
    root_url "https://homebrew-bottles.s3.fr-par.scw.cloud/k7"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "b3ecc9278a56d198cbad7af6901f67537d06141d48362afe8044133853463382"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "0f6437f6c5e977db235fc621945ab441128f030b39e2c4d37ed8050a48697c28"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "e389d4c42755caebeaac00cadac44d0b05be62c468bcc2505c6fa5915a43b99c"
  end

  head "https://github.com/samoht/ocaml-k7.git", branch: "main"

  depends_on "ocaml" => :build
  depends_on "opam" => :build
  depends_on "dune" => :build
  depends_on "vhs" => :recommended

  def install
    system "opam", "init", "--disable-sandboxing", "--no-setup", "-y" unless File.exist?("#{Dir.home}/.opam")
    system "opam", "install", ".", "--deps-only", "-y", "--working-dir"
    system "opam", "exec", "--", "dune", "build", "bin/main.exe"
    bin.install "_build/default/bin/main.exe" => "k7"
  end

  test do
    system bin/"k7", "--help"
  end
end
