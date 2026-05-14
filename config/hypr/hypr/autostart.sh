#!/bin/bash

# Ensure GPU is available
export EGL_DEVICE_ID=0
export LIBGL_ALWAYS_SOFTWARE=0

# Give outputs time to initialize
sleep 2

# Start hyprpaper
hyprpaper &

# Start other apps
waybar &
kitty &

