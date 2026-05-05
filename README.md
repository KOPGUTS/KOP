# opencode Portable

Portable version of [opencode](https://github.com/anomalyco/opencode) — plug into any computer, no install needed.

All config, cache, and API keys stay on the USB drive. Nothing touches the host system.

## Quick Start

**Linux / macOS:**

```bash
bash setup.sh    # first time: downloads opencode, configures API key
bash opencode.sh # launch
```

**Windows:**

```bash
setup.bat        # first time
opencode.bat     # launch
```

## How It Works

The launcher scripts (`opencode.sh` / `opencode.bat`) redirect the `HOME` environment variable to the `home/` directory on the USB, so opencode reads config and writes cache there — fully portable.

```
opencode-portable/
├── bin/               # opencode binary (downloaded by setup)
├── home/              # portable home — config, cache, API key
│   └── .config/opencode/
├── opencode.sh        # Linux/macOS launcher
├── opencode.bat       # Windows launcher
├── setup.sh           # First-time setup (Linux/macOS)
└── setup.bat          # First-time setup (Windows)
```

## Get an API Key

- DeepSeek: https://platform.deepseek.com
- Anthropic: https://console.anthropic.com
- OpenAI: https://platform.openai.com

## Security

The `home/` directory contains your API key. This repo excludes it via `.gitignore`. Never commit your `home/` folder.
