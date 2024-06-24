XOTODOT_TMUX_LIGHT="src/xotodot-terminal-tmuxtile-status.conf"
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

main() {
  tmux source-file "$CURRENT_DIR/$XOTODOT_TMUX_LIGHT"
}

main
