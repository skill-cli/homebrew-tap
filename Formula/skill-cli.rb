class SkillCli < Formula
  desc "Install and update agent skills, resolved to exact versions"
  homepage "https://github.com/skill-cli/cli"
  url "https://github.com/skill-cli/cli/archive/refs/tags/v0.3.1.tar.gz"
  sha256 "1777948c634f4c3b8dccf36c6bb7e2d2d790c761e51ad764b30415c29aa0c4eb"
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
