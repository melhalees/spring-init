# 🌱 Spring Init

A CLI tool to help you initialize Spring Boot projects interactively using `spring init`, enhanced with fuzzy selection (`fzf`) and cross-platform support.

---

## 📦 Features

- ✅ Detects your operating system (Linux, macOS, or Windows via WSL/Git Bash)
- ✅ Installs [fzf](https://github.com/junegunn/fzf) automatically if not available (on supported systems)
- ✅ Downloads and installs the `spring-init.sh` script from GitHub
- ✅ Adds it to your `PATH` automatically
- ✅ Launches via the `spring-init` command
- 🚀 Designed for quick project scaffolding with Spring Initializr

---

## 🛠️ Installation

### 1. One-liner install script

Paste this in your terminal:

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/melhalees/spring-init/master/install.sh)"
```

### 2. Restart your terminal or reload shell config
```bash
source ~/.bashrc  # or ~/.zshrc depending on your shell
```
### 3. Usage
After installation, simply run:
```bash
spring-init
```
You'll be guided through project creation steps, and you can fuzzy-search for dependencies (planned feature).

## 🖥️ Supported Platforms

| OS       | Status     | Notes                                                  |
|----------|------------|--------------------------------------------------------|
| Linux    | ✅ Supported | Installs `fzf` automatically via `apt` if available     |
| macOS    | ✅ Supported | Installs `fzf` automatically via `brew`                |
| Windows  | ⚠️ Partial  | Works via **WSL** or **Git Bash** (manual `fzf` install may be needed) |


## 📂 Where is the Script Installed?

The CLI tool will be installed to:

```bash
~/.local/bin/spring-init
```
## 🧾 License

MIT License © 2025 [Mohamed Elhalees](https://github.com/melhalees)

## 🤝 Contribute

Have ideas for better prompts, features, or integration with more tools?  
PRs and issues are welcome — feel free to contribute!


