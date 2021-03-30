info() {
  local msg="$1"
  echo "# [INFO] $msg" >&3
}

setup() {
  info "Before test"
}

teardown() {
  info "After test"
}
