#!/usr/bin/env python3
from kitty.boss import get_boss
import time
import sys

def main(args):
    # Wait for 3 seconds
    time.sleep(3)
    # Print "Hello, world!" to the terminal
    print("Hello, world!")
    # Flush the output to ensure it appears before closing
    sys.stdout.flush()
    # Wait a moment to allow the user to see the message
    time.sleep(2)
    # Close the window
    boss = get_boss()
    if boss:
        w_id = boss.active_window_id
        boss.close_window(w_id)
    return 0

def handle_result(args, result, target_window_id, boss):
    pass
