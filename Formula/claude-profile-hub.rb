class ClaudeProfileHub < Formula
  desc "Run separate Claude Desktop profiles side by side, each with its own sign-in"
  homepage "https://github.com/slukedev/claude-profile-hub"
  version "0.1.0"
  license "MIT"

  base = "https://github.com/slukedev/claude-profile-hub/releases/download/v0.1.0/claude-profile-hub"

  on_macos do
    on_arm do
      url "#{base}-aarch64-apple-darwin.tar.gz"
      sha256 "c2ad0101fb7e1e40be4cd2696c0151300b9b1ce4d3020b424d11c8b97a2fa33e"
    end
    on_intel do
      url "#{base}-x86_64-apple-darwin.tar.gz"
      sha256 "1752efa68456aa8736148dd4fa6b0047b97c5fcebc3dd8096fa1b4fc329715d3"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-aarch64-unknown-linux-musl.tar.gz"
      sha256 "51558da6878e596c046a9cf1660d2ab45ab779a9834900cbe5e00d75f5f2a9f3"
    end
    on_intel do
      url "#{base}-x86_64-unknown-linux-musl.tar.gz"
      sha256 "62dca6088efe8c6b5f9d75308baf7fbe20b4dc924178e8d7d3d82266e9553018"
    end
  end

  def install
    bin.install "claude-profile-hub"
    generate_completions_from_executable(bin/"claude-profile-hub", "completions")
  end

  def caveats
    <<~EOS
      Run `claude-profile-hub` to set up your profiles.
      Coming from claude-fix? Run `claude-profile-hub migrate` to bring your profiles over.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/claude-profile-hub --version")
    ENV["CLAUDE_PROFILE_HUB_HOME"] = testpath
    system bin/"claude-profile-hub", "config", "app-shortcuts", "off"
    system bin/"claude-profile-hub", "add", "Work"
    assert_match "Work", shell_output("#{bin}/claude-profile-hub list")
  end
end
