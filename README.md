# homebrew-codeburn

Homebrew tap for [`@soumyadebroy3/codeburn`](https://github.com/soumyadebroy3/codeburn) — a fork of [`getagentseal/codeburn`](https://github.com/getagentseal/codeburn) that tracks where your AI coding tokens go (Claude, Codex, Cursor, Copilot, and 14 other tools).

## Install

```bash
brew tap soumyadebroy3/codeburn
brew install codeburn
```

After installation:

```bash
codeburn          # interactive dashboard
codeburn export --format html --all-projects
codeburn menubar  # install the macOS menu-bar app
```

## Updating the formula

When a new release is cut on the main repo, update `Formula/codeburn.rb`:

1. Bump `url` to the new `archive/refs/tags/vX.Y.Z.tar.gz`
2. Recompute `sha256` with `curl -sfL <url> | shasum -a 256`
3. Commit + push

## License

MIT (matches the upstream codeburn licence).
