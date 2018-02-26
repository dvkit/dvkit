

ifneq (1,$(RULES))

PSDE_VERSION = 0.0.5
PSDE_ZIP = psde-$(PSDE_VERSION).jar
PSDE_URL = https://dl.bintray.com/mballance/psstools/psde/$(PSDE_VERSION)/release/$(PSDE_ZIP)
PSDE_DIR = $(BUILD_TOOLS_DIR)/psde
PSDE_REPOS = $(call ECLIPSE_REPOSITORY_URL,$(PSDE_DIR))

PSDE_FEATURES := org.psstools.psde.lang.feature.feature.group

else

$(BUILD_TOOLS_DIR)/psde.unpack : $(PACKAGES_DIR)/$(PSDE_ZIP)
	$(Q)if test ! -d `dirname $@`; then mkdir -p `dirname $@`; fi
	$(Q)rm -rf $(PSDE_DIR)
	$(Q)mkdir -p $(PSDE_DIR)
	$(Q)cd $(PSDE_DIR) ; $(UNZIP) $^
	$(Q)touch $@
	
psde.install : $(BUILD_TOOLS_DIR)/psde.unpack xtext.runtime.install
	$(Q)$(call ECLIPSE_INSTALL_IU, $(PSDE_FEATURES), $(PSDE_REPOS), \
		PSDE, $(PARENT_DIR_A))
	$(Q)touch $@
	
$(PACKAGES_DIR)/$(PSDE_ZIP) : 
	$(Q)if test ! -d `dirname $@`; then mkdir -p `dirname $@`; fi
	$(Q)wget -O $@ $(PSDE_URL)

endif
