BATS_CORE_VERSION ?= v1.3.0
BATS_SUPPORT_VERSION ?= v0.3.0
BATS_ASSERT_VERSION ?= v2.0.0

TARGET_DIR = $(CURDIR)/target
TEST_REPORTS_DIR = $(TARGET_DIR)/test-reports
BATS = $(TARGET_DIR)/bats-core-latest/bin/bats
TEST ?= tests/*.bats

define get_bats
	@if [[ ! -d $(TARGET_DIR)/$(1)-$(2) ]]; then git -c advice.detachedHead=false clone --depth 1 --branch $(2) https://github.com/bats-core/$(1).git $(TARGET_DIR)/$(1)-$(2); fi
	@rm -rf "$(TARGET_DIR)/$(1)-latest"
	@ln -s "$(TARGET_DIR)/$(1)-$(2)" "$(TARGET_DIR)/$(1)-latest"
endef

test: install
	@echo "Run test $(TEST)"
	@mkdir -p $(TEST_REPORTS_DIR)
	@$(BATS) --formatter tap --report-formatter junit --output $(TEST_REPORTS_DIR) $(TEST)

install:
	$(call get_bats,"bats-core",$(BATS_CORE_VERSION))
	$(call get_bats,"bats-support",$(BATS_SUPPORT_VERSION))
	$(call get_bats,"bats-assert",$(BATS_ASSERT_VERSION))
	@$(BATS) -v

clean:
	rm -rf $(TARGET_DIR)
