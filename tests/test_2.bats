#!/usr/bin/env bats

load libraries

test_wait() {
  local count="$1"
  for i in $(seq 1 $count); do
    local time=$((count-i+1))
    info "Test will start in $time s"
    sleep 1
  done
}

@test "Test with output" {
  test_wait 3
  local actual="$TEST_STRING"
  local expected="abc"
  assert_equal "$actual" "$expected"
  info "Test completed"
}
