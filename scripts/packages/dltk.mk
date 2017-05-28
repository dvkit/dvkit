

ifneq (1,$(RULES))

DLTK_VERSION = 5.6
DLTK_ZIP = dltk-R-$(DLTK_VERSION)-401608300412.zip
DLTK_URL = $(ECLIPSE_MIRROR_URL)/technology/dltk/downloads/drops/R$(DLTK_VERSION)/R-$(DLTK_VERSION)-201608300412/$(DLTK_ZIP)
DLTK_DIR = $(BUILD_TOOLS_DIR)/dltk
DLTK_REPOS = $(call ECLIPSE_REPOSITORY_URL,$(DLTK_DIR)),$(call ECLIPSE_REPOSITORY_URL,$(ECLIPSE_PLATFORM_DIR))

DLTK_FEATURES := org.eclipse.dltk.tcl.feature.group

else

dltk.install : $(BUILD_TOOLS_DIR)/dltk.unpack \
	gef.install launchbar.install tm_terminal_ctrl.install

$(BUILD_TOOLS_DIR)/dltk.unpack : $(PACKAGES_DIR)/$(DLTK_ZIP)
	$(Q)if test ! -d `dirname $@`; then mkdir -p `dirname $@`; fi
	$(Q)rm -rf $(DLTK_DIR)
	$(Q)mkdir -p $(DLTK_DIR)
	$(Q)cd $(DLTK_DIR) ; unzip $^
	$(Q)touch $@
	
dltk.install : $(BUILD_TOOLS_DIR)/dltk.unpack jdt.install
	$(Q)$(call ECLIPSE_INSTALL_IU, $(DLTK_FEATURES), $(DLTK_REPOS), \
		DLTK, $(PARENT_DIR_A))
	$(Q)touch $@
	
$(PACKAGES_DIR)/$(DLTK_ZIP) : 
	$(Q)if test ! -d `dirname $@`; then mkdir -p `dirname $@`; fi
	$(Q)wget -O $@ $(DLTK_URL)

endif
