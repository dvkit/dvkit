

ifneq (1,$(RULES))

SHELLED_VERSION = 2.0.3
SHELLED_ZIP = net.sourceforge.shelled-site-$(SHELLED_VERSION).zip
SHELLED_URL = http://sourceforge.net/projects/shelled/files/shelled/ShellEd%20$(SHELLED_VERSION)/$(SHELLED_ZIP)/download
SHELLED_DIR = $(BUILD_TOOLS_DIR)/shelled
SHELLED_REPOS = $(call ECLIPSE_REPOSITORY_URL,$(SHELLED_DIR))

SHELLED_FEATURES := net.sourceforge.shelled.feature.group

else

$(BUILD_TOOLS_DIR)/shelled.unpack : $(PACKAGES_DIR)/$(SHELLED_ZIP)
	$(Q)if test ! -d `dirname $@`; then mkdir -p `dirname $@`; fi
	$(Q)rm -rf $(SHELLED_DIR)
	$(Q)mkdir -p $(SHELLED_DIR)
	$(Q)cd $(SHELLED_DIR) ; unzip $^
	$(Q)touch $@
	
shelled.install : $(BUILD_TOOLS_DIR)/shelled.unpack
	$(Q)$(call ECLIPSE_INSTALL_IU, $(SHELLED_FEATURES), $(SHELLED_REPOS), \
		SHELLED, $(PARENT_DIR_A))
	$(Q)touch $@
	
$(PACKAGES_DIR)/$(SHELLED_ZIP) : 
	$(Q)if test ! -d `dirname $@`; then mkdir -p `dirname $@`; fi
	$(Q)wget -O $@ $(SHELLED_URL)

endif
