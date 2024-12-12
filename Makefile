BATS_CORE_VERSION ?= v1.11.1
BATS_SUPPORT_VERSION ?= v0.3.0
BATS_ASSERT_VERSION ?= v2.1.0

TARGET = $(CURDIR)/target
BATS = $(TARGET)/bats-core-latest/bin/bats

# By default, all tests in tests/*.bats will be executed.
# You can also overwrite it in cmd as follows
#    make test TEST=tests/test_1.bats
TEST ?= tests/*.bats

# Folder for test resources. This variable will be accessible from any test.
export TEST_RESOURCES = $(CURDIR)/tests/test-resources

# Folder for test reports. This variable will be accessible from any test.
export TEST_REPORTS = $(TARGET)/test-reports

# Change it if you want failing tests.
# You can also overwrite it in cmd as follows
#    make test TEST_STRING=xyz
export TEST_STRING=abc

# Internal function for getting a specifi bats library.
define get_bats
	@if [[ ! -d $(TARGET)/$(1)-$(2) ]]; then git -c advice.detachedHead=false clone --depth 1 --branch $(2) https://github.com/bats-core/$(1).git $(TARGET)/$(1)-$(2); fi
	@rm -rf "$(TARGET)/$(1)-latest"
	@ln -s "$(TARGET)/$(1)-$(2)" "$(TARGET)/$(1)-latest"
endef

# Install all needed bats libraries.
install-bats:
	$(call get_bats,"bats-core",$(BATS_CORE_VERSION))
	$(call get_bats,"bats-support",$(BATS_SUPPORT_VERSION))
	$(call get_bats,"bats-assert",$(BATS_ASSERT_VERSION))
	@$(BATS) -v

# Execute test(s).
test: install-bats
	@echo "Run test $(TEST)"
	@mkdir -p $(TEST_REPORTS)
	@$(BATS) --formatter tap --report-formatter junit --output $(TEST_REPORTS) $(TEST)

# Clean all generated files including bats libraries.
clean:
	rm -rf $(TARGET)
