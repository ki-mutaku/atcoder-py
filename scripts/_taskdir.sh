# 引数（main.py のパス / 問題ディレクトリ / 省略時はカレント）から問題ディレクトリを決める
taskdir() {
  local p="${1:-.}"
  [ -f "$p" ] && p="$(dirname "$p")"
  if [ ! -f "$p/main.py" ]; then
    echo "main.py が見つかりません: $p" >&2
    exit 1
  fi
  (cd "$p" && pwd)
}
