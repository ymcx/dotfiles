#!/usr/bin/nu

def main [ACTION: string] {
  brightnessctl s $"10%($ACTION)" -n1
}
