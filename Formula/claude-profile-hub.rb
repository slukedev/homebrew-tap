class ClaudeProfileHub < Formula
  desc "Run separate Claude Desktop profiles side by side, each with its own sign-in"
  homepage "https://github.com/slukedev/claude-profile-hub"
  version "0.2.0"
  license "MIT"

  base = "https://github.com/slukedev/claude-profile-hub/releases/download/v0.2.0/claude-profile-hub"

  on_macos do
    on_arm do
      url "#{base}-aarch64-apple-darwin.tar.gz"
      sha256 "79a3fc7b0f380a26ac1c115ca97cdfdc6958b0d19dc0981c1f0bc6bcab636d0c"
    end
    on_intel do
      url "#{base}-x86_64-apple-darwin.tar.gz"
      sha256 "bb383e0633a1bf32866a7fb6419fc30904856f68e042e06fc08a5a73eef52648"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-aarch64-unknown-linux-musl.tar.gz"
      sha256 "4f5997d1b2529ef8c7be469a012920aa2f83996e32f9fe82410a98e5f55df68e"
    end
    on_intel do
      url "#{base}-x86_64-unknown-linux-musl.tar.gz"
      sha256 "bdf59430125e8367ddc8e42a869c0e297cfa2012a3355d7bf235387d6eb62caa"
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
