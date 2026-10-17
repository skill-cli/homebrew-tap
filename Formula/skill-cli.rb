class SkillCli < Formula
  desc "Native skill CLI for installing and watching agent skills"
  homepage "https://github.com/skill-cli/cli"
  url "https://github.com/skill-cli/cli/archive/refs/tags/v0.2.2.tar.gz"
  sha256 "34fb77b24f3856733b74f45e432fe72dc96edd4f99a417220fb99ec05c4656f2"
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
    assert_match(/\A\d+\.\d+\.\d+/, shell_output("#{bin}/skill --version"))
    assert_match "Native agent skill CLI", shell_output("#{bin}/skill --help")
    assert_match(/\A\d+\.\d+\.\d+/, shell_output("#{bin}/swift-skill --version"))
    unknown = shell_output("#{bin}/skill unknown-command --help 2>&1", 64)
    assert_match "Unknown command 'unknown-command'", unknown
  end
end
