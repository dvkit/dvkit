

ifneq (1,$(RULES))

CDT_VERSION = 9.5
CDT_MINOR_VERSION=2
CDT_ZIP = cdt-$(CDT_VERSION).$(CDT_MINOR_VERSION).zip
CDT_URL = $(ECLIPSE_MIRROR_URL)/tools/cdt/releases/$(CDT_VERSION)/cdt-$(CDT_VERSION).$(CDT_MINOR_VERSION)/$(CDT_ZIP)
CDT_DIR = $(BUILD_TOOLS_DIR)/cdt
CDT_REPOS = $(call ECLIPSE_REPOSITORY_URL,$(CDT_DIR)),$(call ECLIPSE_REPOSITORY_URL,$(ECLIPSE_PLATFORM_DIR))

CDT_FEATURES := org.eclipse.cdt.feature.group

else

$(BUILD_TOOLS_DIR)/cdt.unpack : $(PACKAGES_DIR)/$(CDT_ZIP)
	$(Q)if test ! -d `dirname $@`; then mkdir -p `dirname $@`; fi
	$(Q)rm -rf $(CDT_DIR)
	$(Q)mkdir -p $(CDT_DIR)
	$(Q)cd $(CDT_DIR) ; $(UNZIP) $^
	$(Q)touch $@
	
cdt.install : $(BUILD_TOOLS_DIR)/cdt.unpack \
	gef.install launchbar.install tm_terminal_ctrl.install
	$(Q)$(call ECLIPSE_INSTALL_IU, $(CDT_FEATURES), $(CDT_REPOS), \
		CDT, $(PARENT_DIR_A))
	$(Q)touch $@
	
$(PACKAGES_DIR)/$(CDT_ZIP) : 
	$(Q)if test ! -d `dirname $@`; then mkdir -p `dirname $@`; fi
	$(Q)wget -O $@ $(CDT_URL)

endif
