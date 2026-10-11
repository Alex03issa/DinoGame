# Dino Game

A Flutter remake of the Chrome offline "T-Rex runner": tap to make the dinosaur jump over incoming cacti and beat your high score.

## Overview

A small mobile game written in Flutter (September 2024) using plain widgets and timers — no game engine. The dinosaur and cactus are positioned with `Alignment` coordinates, a periodic timer moves the cactus across the screen, and the jump follows a simple projectile equation (`h = -g/2 * t² + v * t`).

## Features

- "TAP TO PLAY" start screen; tap to start, tap to jump, tap again after game over to restart
- Physics-based jump with gravity and initial velocity, with double-jump prevention while mid-air
- Endlessly looping cactus obstacle
- Collision detection between the dinosaur and the cactus
- Score (+1 per cactus cleared) and session high score
- "GAME OVER" overlay
- Portrait orientation lock

## Tech Stack

- Flutter / Dart (SDK >= 3.4.4)
- Material widgets, `dart:async` timers

## Project Structure

```
lib/
├── main.dart          # App entry, portrait lock
├── homepage.dart      # Game state: timers, jump physics, collision, scoring
├── dino.dart          # Dinosaur sprite widget
├── barrier.dart       # Cactus obstacle widget
├── scorescreen.dart   # Score / high score display
├── taptoplay.dart     # Start prompt
├── gameover.dart      # Game over overlay
└── images/            # dino.png, cactus.png
android/  ios/         # Platform runners
test/widget_test.dart  # Default Flutter widget test
```

## Getting Started

Prerequisites: [Flutter SDK](https://docs.flutter.dev/get-started/install) 3.22+ and an Android emulator/device (or Xcode for iOS).

```bash
git clone https://github.com/Alex03issa/DinoGame.git
cd DinoGame
flutter pub get
flutter run
```

## Notes

- The high score is kept in memory only (resets when the app restarts).
- `test/widget_test.dart` is the default Flutter counter test and does not match this app.

## Author

Alexander Issa — [@Alex03issa](https://github.com/Alex03issa)
