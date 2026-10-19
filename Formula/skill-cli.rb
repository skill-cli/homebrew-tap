class SkillCli < Formula
  desc "Install and update agent skills, resolved to exact versions"
  homepage "https://github.com/skill-cli/cli"
  url "https://github.com/skill-cli/cli/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "d3f77126cba548ff6397f8983ede95db7491749ea9151f1a4d10f83db507b11f"
  license "MIT"
  head "https://github.com/skill-cli/cli.git", branch: "master"

  depends_on xcode: :build
  depends_on macos: :ventura

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
