class SkillCli < Formula
  desc "Install and update agent skills, resolved to exact versions"
  homepage "https://github.com/skill-cli/cli"
  url "https://github.com/skill-cli/cli/archive/refs/tags/v0.3.2.tar.gz"
  sha256 "902bde0bfc74723e55f97353f2babf695adf02c054879a5e38e7b63061e49edd"
  license "MIT"
  head "https://github.com/skill-cli/cli.git", branch: "master"

  depends_on xcode: ["26.4", :build]
  depends_on macos: :sequoia

  def install
    system "swift", "build", "-c", "release", "--disable-sandbox", "--product", "skill"
    bin.install ".build/release/skill"
    bin.install_symlink bin/"skill" => "swift-skill"
  end

  test do
    assert_equal "skill #{version}", shell_output("#{bin}/skill --version").strip
    assert_match "Manage agent skills from declared sources.", shell_output("#{bin}/skill --help")
    assert_equal "skill #{version}", shell_output("#{bin}/swift-skill --version").strip
    unknown = shell_output("#{bin}/skill unknown-command --help 2>&1", 64)
    assert_match "Unknown command 'unknown-command'", unknown
  end
end
