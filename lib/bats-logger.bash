log() {
  local msg="$1"
  local level="${2:-INFO}"
  echo "# [$level] $msg" >&3
}

info() {
  log "$1" "INFO"
}

trace() {
  log "$1" "TRACE"
}

error() {
  log "$1" "ERROR"
  exit 1
}
