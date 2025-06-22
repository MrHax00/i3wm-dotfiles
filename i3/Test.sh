#!/usr/bin/env bash

while IFS= read -r line; do
  printf '%s\n' "$line"
done
