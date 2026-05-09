class Codeburn < Formula
  desc "See where your AI coding tokens go - by task, tool, model, and project"
  homepage "https://github.com/soumyadebroy3/codeburn"
  url "https://github.com/soumyadebroy3/codeburn/archive/refs/tags/v2.3.0.tar.gz"
  sha256 "d0ffd747768b9f81d6c3823051f0cc14eda7db652ad9cf1edaa27eff80612091"
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
