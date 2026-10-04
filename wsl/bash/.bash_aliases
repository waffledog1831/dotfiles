# Ubuntu の fd-find を fd として使う。
if command -v fdfind >/dev/null 2>&1; then
  alias fd=fdfind
fi
