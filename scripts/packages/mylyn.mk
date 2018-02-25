

ifneq (1,$(RULES))

MYLYN_VERSION = 3.24.0
MYLYN_ZIP = mylyn-$(MYLYN_VERSION).v20170705-2102.zip
MYLYN_URL = $(ECLIPSE_MIRROR_URL)/mylyn/drops/$(MYLYN_VERSION)/v20170705-2102/$(MYLYN_ZIP)
MYLYN_DIR = $(BUILD_TOOLS_DIR)/mylyn
MYLYN_REPOS = $(call ECLIPSE_REPOSITORY_URL,$(MYLYN_DIR)),$(call ECLIPSE_REPOSITORY_URL,$(ECLIPSE_PLATFORM_DIR))

MYLYN_FEATURES := org.eclipse.mylyn_feature.feature.group

else

$(BUILD_TOOLS_DIR)/mylyn.unpack : $(PACKAGES_DIR)/$(MYLYN_ZIP)
	$(Q)if test ! -d `dirname $@`; then mkdir -p `dirname $@`; fi
	$(Q)rm -rf $(MYLYN_DIR)
	$(Q)mkdir -p $(MYLYN_DIR)
	$(Q)cd $(MYLYN_DIR) ; $(UNZIP) $^
	$(Q)touch $@
	
mylyn.install : $(BUILD_TOOLS_DIR)/mylyn.unpack \
	gef.install launchbar.install tm_terminal_ctrl.install
	$(Q)$(call ECLIPSE_INSTALL_IU, $(MYLYN_FEATURES), $(MYLYN_REPOS), \
		MYLYN, $(PARENT_DIR_A))
	$(Q)touch $@
	
$(PACKAGES_DIR)/$(MYLYN_ZIP) : 
	$(Q)if test ! -d `dirname $@`; then mkdir -p `dirname $@`; fi
	$(Q)wget -O $@ $(MYLYN_URL)

endif
