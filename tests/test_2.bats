#!/usr/bin/env bats

load libraries

@test "Test with output" {
  info "Test starts in 5"
  sleep 1
  info "Test starts in 4"
  sleep 1
  info "Test starts in 3"
  sleep 1
  info "Test starts in 2"
  sleep 1
  info "Test starts in 1"
  sleep 1
  local actual="$TEST_STRING"
  local expected="abc"
  assert_equal "$actual" "$expected"
  info "Test completed"
}
