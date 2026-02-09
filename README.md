# RuneKit

**Alt1-compatible toolbox for RuneScape 3 on Linux and macOS.**

RuneKit lets you run [Alt1 toolkit](https://runeapps.org/alt1) apps (clue solvers, XP meters, AFK timers, and more) alongside the **official RuneScape 3 client** on Linux and macOS. It works by reading your game screen through screenshots — it does not modify the game client.

Modernized fork of [whs/runekit](https://github.com/whs/runekit), updated to Python 3.11+, PySide6/Qt6, and current dependencies.

---

## What You Need

| Requirement | Details |
|---|---|
| **OS** | Linux (X11) or macOS 12+ |
| **Python** | 3.11, 3.12, 3.13, or 3.14 |
| **RuneScape 3** | Official client must be **running** before you start RuneKit |
| **Display server** | X11 required on Linux (Wayland is not supported) |

## Quick Start (Linux)

### Step 1: Install system dependencies

**Ubuntu / Debian / Linux Mint:**
```sh
sudo apt install -y python3-full pipx libxcb-cursor0
```

**Fedora:**
```sh
sudo dnf install -y python3 pipx libxcb-cursor
```

**Arch Linux:**
```sh
sudo pacman -S python pipx xcb-util-cursor
```

### Step 2: Install Poetry (Python package manager)

```sh
pipx install poetry
```

If `pipx` says to add `~/.local/bin` to your PATH, do that:
```sh
# Add to your ~/.bashrc or ~/.zshrc:
export PATH="$HOME/.local/bin:$PATH"
```

Then restart your terminal or run `source ~/.bashrc`.

### Step 3: Clone and install RuneKit

```sh
git clone https://github.com/YOUR_USERNAME/runekit.git
cd runekit
poetry install
```

This creates a virtual environment and installs all Python dependencies. It may take a minute.

### Step 4: Build resources

```sh
poetry run make dev
```

### Step 5: Launch RuneKit

1. **Start RuneScape 3 first** (the official client)
2. Then run:

```sh
poetry run python main.py
```

3. A **system tray icon** will appear in your panel (top-right area)
4. **Right-click the tray icon** to see available Alt1 apps
5. On first launch, RuneKit downloads the default app list from runeapps.org

### One-Click Launcher

After setup, you can use the included launcher script:

```sh
./RuneKit.sh
```

This script checks for dependencies and launches RuneKit. You can also double-click it in your file manager (make sure it's marked executable with `chmod +x RuneKit.sh`).

---

## Quick Start (macOS)

### Step 1: Install dependencies

```sh
brew install python pipx
pipx install poetry
```

### Step 2: Clone and install

```sh
git clone https://github.com/YOUR_USERNAME/runekit.git
cd runekit
poetry install
poetry run make dev
```

### Step 3: Launch

1. Start RuneScape 3
2. Run `poetry run python main.py`
3. Grant permissions when prompted:
   - **Accessibility** — for access to game window
   - **Input Monitoring** — for hooking Alt+1 and idle detection
   - **Screen Recording** — for capturing the game screen
4. **Quit and restart RuneKit** after granting permissions
5. The tray icon appears in the menu bar (top-right)

---

## Available Alt1 Apps

RuneKit automatically downloads these apps on first launch:

| App | What it does |
|---|---|
| **AFKWarden** | Alerts you when you stop gaining XP or need attention |
| **Clue Solver** | Solves clue scroll puzzles, compass clues, and map clues |
| **Stats** | Shows your skill stats and XP tracking |
| **XpMeter** | Real-time XP/hour tracking overlay |
| **RS Wiki** | Quick item/NPC/object lookup from the RS Wiki |
| **DgKey** | Dungeoneering key tracker |
| **Droplogger** | Logs your drops for tracking loot |

You can also load any custom Alt1 app by URL:
```sh
poetry run python main.py https://runeapps.org/apps/alt1/afkscape/appconfig.json
```

---

## Troubleshooting

### "No game instance found"

- Make sure RuneScape 3 is **running** before you start RuneKit
- RuneKit looks for a window named "RuneScape". If your window has a different name, set:
  ```sh
  export RK_WM_APP_NAME="YourWindowName"
  ```

### Tray icon doesn't appear

- Some desktop environments hide tray icons. Check your panel settings
- On GNOME, you may need the [AppIndicator extension](https://extensions.gnome.org/extension/615/appindicator-support/)

### Black screen / overlay issues

- RuneKit requires **X11**. If you're on Wayland, switch to an X11 session at the login screen
- Or run with XWayland: `QT_QPA_PLATFORM=xcb poetry run python main.py`

### "Failed to load module xapp-gtk3-module"

- This is a harmless warning from your desktop environment. Ignore it.

### "GBM is not supported" / Vulkan fallback

- This is normal — Qt WebEngine falls back to Vulkan rendering. Everything works fine.

### macOS: "Screen Recording permission" error

- Go to System Preferences > Security & Privacy > Privacy > Screen Recording
- Enable RuneKit / Python
- Quit and restart RuneKit

---

## Bug Reports

If something isn't working, please open a GitHub Issue and **include your log file**.

RuneKit automatically saves logs to:

| OS | Log location |
|---|---|
| **Linux** | `~/.config/cupco.de/RuneKit/logs/runekit.log` |
| **macOS** | `~/Library/Preferences/cupco.de/RuneKit/logs/runekit.log` |

Logs rotate automatically (3 files, 1MB each) so they won't fill your disk.

**To submit a bug report:**

1. Reproduce the issue
2. Find your log file (see paths above)
3. Open a [GitHub Issue](https://github.com/YOUR_USERNAME/runekit/issues/new) with:
   - What you were doing when it broke
   - Your distro and desktop environment (e.g., "Ubuntu 24.04, GNOME on X11")
   - Attach or paste your `runekit.log` file

---

## Settings

Open the settings dialog:
```sh
poetry run python main.py settings
```

---

## Debugging

Enable the Chromium remote debugger:
```sh
poetry run python main.py --remote-debugging-port=9222
```
Then open `chrome://inspect` in Chrome/Chromium to debug Alt1 apps.

---

## Building from Source

### AppImage (Linux)

```sh
poetry run make dist/RuneKit.AppImage
```

### macOS .app

```sh
poetry run make dist/RuneKit.app.zip
```

---

## Tech Stack

- **Python 3.11–3.14** with [Poetry](https://python-poetry.org) for dependency management
- **PySide6 / Qt6** for the UI, web engine, and overlay system
- **OpenCV** and **Pillow** for image processing (screen capture)
- **xcffib** for X11 window detection (Linux)
- **pyobjc** for Quartz window access (macOS)

---

## License

This project is [licensed](LICENSE) under GPLv3, and contains code from [third parties](THIRD_PARTY_LICENSE.md).
Contains code from the Alt1 application.

Please do not contact Alt1 or RuneApps.org for support with RuneKit.
