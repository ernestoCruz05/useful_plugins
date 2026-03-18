# Useful Plugins for mplug

A collection of Lua plugins for [mplug](https://github.com/ernestoCruz05/mplug), a Lua-based plugin manager and runtime for MangoWM.

---

## Plugins

### 1. `all-float.lua`

Automatically makes new windows floating when they are created on a specific tag. It also randomizes the initial window dimensions and position to prevent overlap.

- **Trigger:** New `ToplevelUpdated` event.
- **Default Tag:** Tag 4 (configurable via `FLOAT_TAG` variable in the script).
- **Features:** Randomizes window size (60-70% of output resolution) and position.

### 2. `autotile.lua`

Automatically switches the active layout based on the number of clients on the current tag.

- **1-2 windows:** Switches to `tile` layout (Master/Slave).
- **3+ windows:** Switches to `scroller` layout (Horizontal strip).
- **Behavior:**
  - Suspends layout switching if any window is in fullscreen mode.
  - Switches layout per-tag (it remembers the desired state for each tag).

### 3. `carousel.lua`

Provides tag cycling (looping) functionality, allowing you to move through tags with "wrap-around" support.

- **Triggers:** Listens for `UserCommand` events via `mplug.sock`.
  - `tag_left`: Moves to the previous tag.
  - `tag_right`: Moves to the next tag.
- **Usage:**
  You can map these to keybindings in your compositor config by using `socat`:

  ```bash
  # Move to the next tag
  echo "trigger tag_right" | socat - UNIX-CONNECT:/tmp/mplug.sock

  # Move to the previous tag
  echo "trigger tag_left" | socat - UNIX-CONNECT:/tmp/mplug.sock
  ```

---

## Installation

### 1. Add the collection

Since these are part of a collection, you can add the entire repository to `mplug`:

```bash
mplug add https://github.com/ernestoCruz05/useful_plugins
```

### 2. Enable the plugins

Enable the specific plugins you want to use. Note that they will be symlinked individually into your `~/.config/mplug/plugins/` directory.

```bash
mplug enable all-float
mplug enable autotile
mplug enable carousel
```

### 3. Restart mplug

Restart the `mplug daemon` for the new plugins to load.

---

## Configuration

Most plugins have configuration variables at the top of their respective `.lua` files. You can find the installed scripts in:
`~/.config/mplug/plugins/useful-plugins/` (which points to the cloned repository).

- **`all-float.lua`**: Change `FLOAT_TAG` to your preferred "floating only" tag.
- **`autotile.lua`**: Adjust `LAYOUT_TILE` and `LAYOUT_SCROLLER` indices if they don't match your MangoWM layout list order.
- **`carousel.lua`**: Adjust `tag_count` if you have a different number of tags (defaults to 9).
