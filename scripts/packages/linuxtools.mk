
# Note: not currently installed

ifneq (1,$(RULES))

LINUXTOOLS_VERSION = 6.1.1
LINUXTOOLS_ZIP = linuxtools-$(LINUXTOOLS_VERSION).zip
LINUXTOOLS_URL = $(ECLIPSE_MIRROR_URL)/linuxtools/$(LINUXTOOLS_ZIP)
LINUXTOOLS_DIR = $(BUILD_TOOLS_DIR)/linuxtools
LINUXTOOLS_REPOS = $(call ECLIPSE_REPOSITORY_URL,$(LINUXTOOLS_DIR)),$(call ECLIPSE_REPOSITORY_URL,$(ECLIPSE_PLATFORM_DIR))

LINUXTOOLS_FEATURES := org.eclipse.linuxtools.feature.group

else

linuxtools.install : $(BUILD_TOOLS_DIR)/linuxtools.unpack \
	gef.install launchbar.install tm_terminal_ctrl.install

$(BUILD_TOOLS_DIR)/linuxtools.unpack : $(PACKAGES_DIR)/$(LINUXTOOLS_ZIP)
	$(Q)if test ! -d `dirname $@`; then mkdir -p `dirname $@`; fi
	$(Q)rm -rf $(LINUXTOOLS_DIR)
	$(Q)mkdir -p $(LINUXTOOLS_DIR)
	$(Q)cd $(LINUXTOOLS_DIR) ; $(UNZIP) $^
	$(Q)touch $@
	
linuxtools.install : $(BUILD_TOOLS_DIR)/linuxtools.unpack
	$(Q)$(call ECLIPSE_INSTALL_IU, $(LINUXTOOLS_FEATURES), $(LINUXTOOLS_REPOS), \
		LINUXTOOLS, $(PARENT_DIR_A))
	$(Q)touch $@
	
$(PACKAGES_DIR)/$(LINUXTOOLS_ZIP) : 
	$(Q)if test ! -d `dirname $@`; then mkdir -p `dirname $@`; fi
	$(Q)wget -O $@ $(LINUXTOOLS_URL)

endif
