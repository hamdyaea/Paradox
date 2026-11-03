#!/usr/bin/env python3
# Developer: Hamdy Abou El Anein
# Contact: hamdy.aea@protonmail.com
# SPDX-License-Identifier: GPL-3.0-or-later
"""Regression tests; operate only in isolated temporary directories."""
from pathlib import Path
import gzip
import subprocess
import tempfile
import unittest

SCRIPT = Path(__file__).resolve().parents[1] / "paradox.bash"


class CompressionTests(unittest.TestCase):
    def test_compression_rounds(self):
        with tempfile.TemporaryDirectory() as tmp:
            target = Path(tmp) / "result"
            result = subprocess.run(
                ["bash", str(SCRIPT), "--output", str(target), "--rounds", "3"],
                capture_output=True, text=True, timeout=20,
            )
            self.assertEqual(result.returncode, 0, result.stderr)
            self.assertEqual(len(list(target.glob("toto*"))), 4)
            self.assertEqual((target / "toto001").read_bytes(), b"blabla\n" * 100)
            content = (target / "toto004").read_bytes()
            for _ in range(3):
                content = gzip.decompress(content)
            self.assertEqual(content, b"blabla\n" * 100)

    def test_existing_directory_never_overwritten(self):
        with tempfile.TemporaryDirectory() as tmp:
            sentinel = Path(tmp) / "sentinel.txt"
            sentinel.write_text("KEEP")
            result = subprocess.run(
                ["bash", str(SCRIPT), "--output", tmp],
                capture_output=True, text=True, timeout=10,
            )
            self.assertEqual(result.returncode, 2)
            self.assertEqual(sentinel.read_text(), "KEEP")

    def test_reject_invalid_rounds(self):
        for count in ("0", "-1", "1001", "abc"):
            with self.subTest(count=count), tempfile.TemporaryDirectory() as tmp:
                result = subprocess.run(
                    ["bash", str(SCRIPT), "--output", str(Path(tmp) / "run"),
                     "--rounds", count],
                    capture_output=True, text=True, timeout=10,
                )
                self.assertEqual(result.returncode, 2)


if __name__ == "__main__":
    unittest.main()
