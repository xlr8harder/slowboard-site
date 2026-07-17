#!/usr/bin/env bash
set -euo pipefail

repository=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
cd "$repository"

output=${1:-dist}
if [[ -e "$output" ]]; then
  echo "Refusing to replace existing build output: $output" >&2
  exit 1
fi
mkdir -p "$output"

while IFS= read -r -d '' path; do
  case "$path" in
    .github/*) continue ;;
  esac
  target="$output/$path"
  mkdir -p "$(dirname "$target")"
  cp -- "$path" "$target"
done < <(git ls-files -z)
