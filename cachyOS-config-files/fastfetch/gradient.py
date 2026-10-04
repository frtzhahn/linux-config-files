#!/usr/bin/env python3
import sys

# Catppuccin Mocha gradient stops (Top -> Mid -> Bottom)
COLOR_START = (203, 166, 247)  # Mauve (#cba6f7)
COLOR_MID = (116, 199, 236)  # Sapphire (#74c7ec)
COLOR_END = (180, 190, 254)  # Lavender (#b4befe)


def interpolate(c1, c2, factor):
    return tuple(int(a + (b - a) * factor) for a, b in zip(c1, c2))


def colorize(input_path, output_path):
    with open(input_path, "r", encoding="utf-8") as f:
        lines = [line.rstrip("\n") for line in f]

    total = len(lines)
    with open(output_path, "w", encoding="utf-8") as out:
        for i, line in enumerate(lines):
            t = i / max(total - 1, 1)
            rgb = interpolate(COLOR_START, COLOR_MID, t *
                              2) if t < 0.5 else interpolate(COLOR_MID, COLOR_END, (t - 0.5) * 2)
            ansi = f"\033[38;2;{rgb[0]};{rgb[1]};{rgb[2]}m"
            out.write(f"{ansi}{line}\033[0m\n")


if __name__ == "__main__":
    src = sys.argv[1] if len(sys.argv) > 1 else "art.txt"
    dst = sys.argv[2] if len(sys.argv) > 2 else "art_colored.txt"
    colorize(src, dst)
    print(f"Gradient applied: {dst}")
