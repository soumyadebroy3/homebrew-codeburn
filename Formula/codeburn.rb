class Codeburn < Formula
  desc "See where your AI coding tokens go - by task, tool, model, and project"
  homepage "https://github.com/soumyadebroy3/codeburn"
  url "https://github.com/soumyadebroy3/codeburn/archive/refs/tags/v2.4.3.tar.gz"
  sha256 "ba8221d4afa0a7616b1428e94a3c93b50804ba2f266f3492023c7304d358866b"
  license "MIT"
  head "https://github.com/soumyadebroy3/codeburn.git", branch: "main"

  depends_on "node"

  def install
    # Run the project's own build (bundles the pinned LiteLLM snapshot, then
    # tsup-bundles dist/cli.js). The litellm pin is locked to a specific
    # upstream commit + SHA-256 so this is fully reproducible from the
    # tarball alone.
    system "npm", "install", "--ignore-scripts"
    system "npm", "run", "build"

    # Copy the built artefact + minimal runtime files into libexec, then
    # symlink the bin so `codeburn` resolves to a clean install dir
    # rather than the unpacked source tree.
    libexec.install Dir["*"]
    (bin/"codeburn").write <<~EOS
      #!/bin/bash
      exec "#{Formula["node"].opt_bin}/node" "#{libexec}/dist/cli.js" "$@"
    EOS
  end

  test do
    assert_match "codeburn", shell_output("#{bin}/codeburn --version")
  end
end
