import os
from pathlib import Path
import subprocess
import tempfile
import unittest


REPO = Path(__file__).resolve().parents[1]


class SetupTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory(prefix='dotfiles setup ')
        self.addCleanup(self.temp.cleanup)
        self.home = Path(self.temp.name)
        self.codex = self.home / 'custom codex'
        self.env = dict(os.environ, HOME=str(self.home), CODEX_HOME=str(self.codex))

    def run_setup(self, platform, success=True):
        result = subprocess.run(
            ['bash', str(REPO / platform / 'setup.sh')],
            env=self.env, capture_output=True, text=True,
        )
        self.assertEqual(result.returncode == 0, success, result.stdout + result.stderr)

    def link(self, destination, source):
        destination.parent.mkdir(parents=True, exist_ok=True)
        destination.symlink_to(source)

    def legacy_links(self):
        pairs = [
            (self.home / '.claude' / name, REPO / 'common/claude' / name)
            for name in ('CLAUDE.md', 'settings.json', 'skills', 'agents')
        ]
        pairs += [
            (self.codex / name, REPO / 'common/codex' / name)
            for name in ('AGENTS.md', 'config.toml', 'agents')
        ]
        pairs += [
            (self.home / '.agents/skills' / name, REPO / 'common/codex/skills' / name)
            for name in ('commit', 'create-pr', 'simplify', 'summon', 'devops')
        ]
        return pairs

    def test_common_only_installs_git(self):
        self.run_setup('common')
        self.run_setup('common')
        self.assertTrue((self.home / '.gitconfig').is_symlink())
        for path in (self.home / '.claude', self.codex, self.home / '.agents'):
            self.assertFalse(path.exists())

    def test_wsl_installs_and_repeats_with_custom_codex_home(self):
        for _ in range(2):
            self.run_setup('wsl')
        for name in ('CLAUDE.md', 'settings.json', 'skills', 'agents'):
            self.assertEqual((self.home / '.claude' / name).resolve(), REPO / 'wsl/claude' / name)
        for name in ('AGENTS.md', 'config.toml', 'agents'):
            self.assertEqual((self.codex / name).resolve(), REPO / 'wsl/codex' / name)
        for skill in (REPO / 'wsl/codex/skills').iterdir():
            self.assertEqual((self.home / '.agents/skills' / skill.name).resolve(), skill)
        self.assertEqual((self.home / '.local/bin/win-powershell').resolve(), REPO / 'wsl/bin/win-powershell')

    def test_wsl_uses_default_codex_home(self):
        self.env.pop('CODEX_HOME')
        self.run_setup('wsl')
        self.assertEqual((self.home / '.codex/config.toml').resolve(), REPO / 'wsl/codex/config.toml')
        self.assertFalse(self.codex.exists())

    def test_wsl_updates_legacy_links_and_preserves_custom_skills(self):
        for destination, source in self.legacy_links():
            self.link(destination, source)
        custom = self.home / 'custom-skill'
        custom.mkdir()
        self.link(self.home / '.agents/skills/docs', custom)
        self.run_setup('wsl')
        self.assertEqual((self.home / '.claude/skills').resolve(), REPO / 'wsl/claude/skills')
        self.assertEqual((self.codex / 'agents').resolve(), REPO / 'wsl/codex/agents')
        self.assertEqual((self.home / '.agents/skills/commit').resolve(), REPO / 'wsl/codex/skills/commit')
        self.assertEqual((self.home / '.agents/skills/docs').resolve(), custom)
        for name in ('summon', 'devops'):
            self.assertFalse((self.home / '.agents/skills' / name).is_symlink())

    def test_windows_does_not_create_ai_directories(self):
        self.run_setup('windows')
        self.run_setup('windows')
        for path in (self.home / '.claude', self.codex, self.home / '.agents'):
            self.assertFalse(path.exists())

    def test_windows_removes_only_legacy_links(self):
        pairs = self.legacy_links()
        for destination, source in pairs:
            self.link(destination, source)
        real_config = self.codex / 'config.toml'
        real_config.unlink()
        real_config.write_text('user config')
        custom = self.home / 'personal-settings.json'
        custom.write_text('{}')
        settings = self.home / '.claude/settings.json'
        settings.unlink()
        settings.symlink_to(custom)
        custom_skill = self.home / '.agents/skills/personal'
        custom_skill.mkdir()
        auth = self.codex / 'auth.json'
        auth.write_text('test auth placeholder')
        history = self.home / '.claude/history.jsonl'
        history.write_text('test history placeholder')
        for _ in range(2):
            self.run_setup('windows')
        for destination, _ in pairs:
            if destination not in (real_config, settings):
                self.assertFalse(destination.is_symlink(), str(destination))
        self.assertEqual(real_config.read_text(), 'user config')
        self.assertEqual(settings.resolve(), custom)
        self.assertTrue(custom_skill.is_dir())
        self.assertEqual(auth.read_text(), 'test auth placeholder')
        self.assertEqual(history.read_text(), 'test history placeholder')

    def test_wsl_preserves_real_skill_directory_on_conflict(self):
        skill = self.home / '.agents/skills/commit'
        skill.mkdir(parents=True)
        marker = skill / 'personal.txt'
        marker.write_text('keep')
        self.run_setup('wsl', success=False)
        self.assertEqual(marker.read_text(), 'keep')


if __name__ == '__main__':
    unittest.main()
