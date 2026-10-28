---
name: disable-stylus-handwriting
description: Brings up the full on-screen keyboard on an Android emulator when a focused text field shows Gboard's stylus handwriting toolbar instead. Use when the toolbar appears but the task needs the on-screen keyboard.
---

Turn off stylus handwriting:

```sh
adb shell settings put secure stylus_handwriting_enabled 0
```

With more than one device connected, add `-s <serial>` after `adb`. The change takes effect without a restart.
