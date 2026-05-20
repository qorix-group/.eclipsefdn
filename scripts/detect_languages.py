#!/usr/bin/env python3
"""Detect code scanning languages for all repos in the eclipse-score org."""

import json
import urllib.request

DATA_URL = "https://eclipse-score.github.io/.github/data.json"

LANGUAGE_MAP = {
    "Python": "python",
    "JavaScript": "javascript-typescript",
    "TypeScript": "javascript-typescript",
    "C": "c-cpp",
    "C++": "c-cpp",
    "Go": "go",
    "Java": "java-kotlin",
    "Kotlin": "java-kotlin",
    "C#": "csharp",
    "Ruby": "ruby",
    "Swift": "swift",
}


def main():
    with urllib.request.urlopen(DATA_URL) as resp:
        data = json.load(resp)

    result = {}
    for repo in data["repos"]:
        langs = set()
        for lang in repo["content"]["top_languages"]:
            if lang in LANGUAGE_MAP:
                langs.add(LANGUAGE_MAP[lang])
        result[repo["name"]] = ["actions"] + sorted(langs)

    for name in sorted(result):
        print(f'  "{name}": {result[name]},')


if __name__ == "__main__":
    main()
