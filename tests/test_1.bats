#!/usr/bin/env bats

load libraries

@test "Assert equals with '=='" {
  local actual="abc"
  local expected="abc"
  [[ "$expected" == "$actual" ]]
}

@test "Assert equals with 'assert_equal'" {
  local actual="abc"
  local expected="abc"
  assert_equal "$actual" "$expected"
}

@test "Assert equals with envvar" {
  local actual="$TEST_STRING"
  local expected="abc"
  assert_equal "$actual" "$expected"
}

@test "Assert equals with a test resource" {
  local actual=$(cat "$TEST_RESOURCES/test.txt")
  local expected="abc"
  assert_equal "$actual" "$expected"
}