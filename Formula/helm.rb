require File.expand_path("../../Homebrew/emacs_formula", __FILE__)

class Helm < EmacsFormula
  desc "Emacs completion and selection narrowing framework"
  homepage "https://emacs-helm.github.io/helm/"
  url "https://github.com/emacs-helm/helm/archive/v2.3.2.tar.gz"
  sha256 "86e6f1540dcda44f3fdd15bdaf8897f4aa625e6eca668a2968a5cc802659aa98"
  head "https://github.com/emacs-helm/helm.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "dc18075abd55a314feebc7574c1f0e1bef0bde418ac72f03c22cf2b2cfb7cb8d" => :sierra
    sha256 "dc18075abd55a314feebc7574c1f0e1bef0bde418ac72f03c22cf2b2cfb7cb8d" => :el_capitan
    sha256 "dc18075abd55a314feebc7574c1f0e1bef0bde418ac72f03c22cf2b2cfb7cb8d" => :yosemite
  end

  depends_on :emacs => "24.3"
  depends_on "homebrew/emacs/async-emacs"

  def install
    system "make"
    elisp.install Dir["*.el"], Dir["*.elc"]
  end

  test do
    (testpath/"test.el").write <<-EOS.undent
      (add-to-list 'load-path "#{share}/emacs/site-lisp/helm")
      (load "helm-config")
      (print (minibuffer-prompt-width))
    EOS
    assert_equal "0", shell_output("emacs -Q --batch -l #{testpath}/test.el").strip
  end
end
