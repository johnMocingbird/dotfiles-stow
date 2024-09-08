# SKHD and Keyboard Maestro Configuration Documentation

## Introduction

This document outlines the `skhd` and Keyboard Maestro configuration used for efficient navigation and workflow management on macOS. The setup is inspired by Vim, utilizing modal keybindings for quick access to various functions.

## Modes Overview

- **Leader Mode**: A central hub for accessing various functions and modes.
- **Window Management Mode**: For managing window layouts and positions.
- **Resize Mode**: Dedicated to resizing windows.
- **Move Mode**: For moving windows across the screen and between spaces.
- **Code Mode**: Shortcuts for coding-related tasks and applications.
- **Safari Mode**: Web browsing shortcuts.
- **System Settings Mode**: Quick access to system settings and utilities.

### Additional Modes (Managed in Keyboard Maestro)

- **Web Layer**: Access to frequently used web resources and actions.
- **Import Layer**: Sub-mode for managing imported data.
- **GitHub Layer**: Sub-mode for navigating GitHub repositories.
- **Bootcamp Layer**: Sub-mode for bootcamp related tasks.
- **Coding Layer**: Shortcuts for navigating coding projects and tasks.

## Keybindings

### Leader Mode (Mode selector) (`leader`)

- a: application Launcher
- **w**: Enter Window Management Mode
- **c**: Enter Coding Layer
- **d**: Launch Directory Selector in Alacritty
- **o**: Open project management software
- **p**: Enter System Settings Mode
- **1, 2, 3, 4**: Navigate between Spaces using virtual key presses of F1-F4 keys

### Window Management Mode (`window_management`)

- **h/j/k/l**: Focus windows in different directions
- **r**: Enter Resize Mode
- **m**: Enter Move Mode
- **space**: Toggle window float
- **g**: Toggle fullscreen
- **f**: Focus parent node
- **s**: Toggle split orientation
- _Other window management keybindings_

### Coding Layer (`c`)

- **b**: Backend projects
- **f**: Frontend projects
- **m**: Mobile projects
- **d**: Dotfiles and to-do lists

### Resize Mode (`resize`)

- **h/j/k/l**: Resize windows in different directions
- _Other resize keybindings_

### Move Mode (`move`)

- **h/j/k/l**: Move windows in different directions
- **1, 2, 3, 4**: Move windows to specific Spaces
- _Other move keybindings_

### Safari Mode (`safari`)

- _Keybindings for navigating and using Safari_

### System Settings Mode (`system_settings`)

- **b**: Open Bluetooth Menu
- **w**: Scan Wi-Fi Networks
- **o**: Set Output Audio Device
- **i**: Set Input Audio Device
- **d**: Toggle Desktop Icon Visibility
- **h**: Toggle Hidden Files Visibility
- **r**: Monitor Layout for OBS Overhead
- **m**: Main Monitor Layout Configuration
- **t**: Open Trash
- _Other system settings keybindings_

### Keyboard Maestro Integrations

- **Web Layer (`w`)**:

  - **s**: State licenses
  - **u**: Users
  - **c**: Certifications
  - **m**: Certify OS
  - **f**: Flags data
  - **l**: Changes web app environment to local
  - **;**: Changes web app environment to staging
  - **'**: Changes web app environment to production
  - **a**: Movingbird app
  - **r**: Opens a menu to select from rule sets (MD, DO, RN, NP, etc.)
  - **i**: Goes to import layer
  - **g**: Goes to GitHub layer
  - **b**: Goes to bootcamp layer

- **Import Layer**:

  - **s**: Imported state licenses
  - **u**: Imported users
  - **c**: Imported certificates

- **GitHub Layer**:

  - **c**: Opens the home page of the selected repo (code page)
  - **p**: Opens PR page of the selected repo
  - **b**: Sets repo to backend
  - **f**: Sets repo to frontend
  - **m**: Sets repo to mobile

- **Bootcamp Layer**:
  - **a**: Clock in to add
  - **c**: Calendly

## Usage Tips

- Ensure `skhd` and Keyboard Maestro are running and configurations are reloaded after changes.
- Familiarize yourself with keybindings in each mode for efficient navigation.
- Customize and expand keybindings based on personal workflow needs.
