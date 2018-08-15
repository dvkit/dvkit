

ifneq (1,$(RULES))

EGIT_VERSION = 5.0.2
EGIT_ZIP = org.eclipse.egit.repository-$(EGIT_VERSION).201807311906-r.zip
EGIT_URL = $(ECLIPSE_MIRROR_URL)/egit/updates-$(EGIT_VERSION)/$(EGIT_ZIP)
EGIT_DIR = $(BUILD_TOOLS_DIR)/egit
EGIT_REPOS = $(call ECLIPSE_REPOSITORY_URL,$(EGIT_DIR)),$(call ECLIPSE_REPOSITORY_URL,$(ECLIPSE_PLATFORM_DIR))

EGIT_FEATURES := org.eclipse.egit.feature.group

else

$(BUILD_TOOLS_DIR)/egit.unpack : $(PACKAGES_DIR)/$(EGIT_ZIP)
	$(Q)if test ! -d `dirname $@`; then mkdir -p `dirname $@`; fi
	$(Q)rm -rf $(EGIT_DIR)
	$(Q)mkdir -p $(EGIT_DIR)
	$(Q)cd $(EGIT_DIR) ; $(UNZIP) $^
	$(Q)touch $@
	
egit.install : $(BUILD_TOOLS_DIR)/egit.unpack \
	gef.install launchbar.install tm_terminal_ctrl.install
	$(Q)$(call ECLIPSE_INSTALL_IU, $(EGIT_FEATURES), $(EGIT_REPOS), \
		EGIT, $(PARENT_DIR_A))
	$(Q)touch $@
	
$(PACKAGES_DIR)/$(EGIT_ZIP) : 
	$(Q)if test ! -d `dirname $@`; then mkdir -p `dirname $@`; fi
	$(Q)wget -O $@ $(EGIT_URL)

endif
