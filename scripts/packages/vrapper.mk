

ifneq (1,$(RULES))

VRAPPER_VERSION = 0.72.0
VRAPPER_ZIP = vrapper_$(VRAPPER_VERSION)_20170311.zip
VRAPPER_URL = https://sourceforge.net/projects/vrapper/files/vrapper/$(VRAPPER_VERSION)/$(VRAPPER_ZIP)/download
VRAPPER_DIR = $(BUILD_TOOLS_DIR)/vrapper
VRAPPER_REPOS = $(call ECLIPSE_REPOSITORY_URL,$(VRAPPER_DIR))

VRAPPER_FEATURES := net.sourceforge.vrapper.feature.group,net.sourceforge.vrapper.eclipse.cdt.feature.feature.group,net.sourceforge.vrapper.eclipse.jdt.feature.feature.group,net.sourceforge.vrapper.eclipse.pydev.feature.feature.group,net.sourceforge.vrapper.plugin.argtextobj.feature.group,net.sourceforge.vrapper.plugin.ipmotion.feature.group,net.sourceforge.vrapper.plugin.splitEditor.feature.group,net.sourceforge.vrapper.plugin.surround.feature.group

else

$(BUILD_TOOLS_DIR)/vrapper.unpack : $(PACKAGES_DIR)/$(VRAPPER_ZIP)
	$(Q)if test ! -d `dirname $@`; then mkdir -p `dirname $@`; fi
	$(Q)rm -rf $(VRAPPER_DIR)
	$(Q)mkdir -p $(VRAPPER_DIR)
	$(Q)cd $(VRAPPER_DIR) ; $(UNZIP) $^
	$(Q)touch $@
	
vrapper.install : $(BUILD_TOOLS_DIR)/vrapper.unpack jdt.install cdt.install
	$(Q)$(call ECLIPSE_INSTALL_IU, $(VRAPPER_FEATURES), $(VRAPPER_REPOS), \
		VRAPPER, $(PARENT_DIR_A))
	$(Q)touch $@
	
$(PACKAGES_DIR)/$(VRAPPER_ZIP) : 
	$(Q)if test ! -d `dirname $@`; then mkdir -p `dirname $@`; fi
	$(Q)wget -O $@ $(VRAPPER_URL)

endif
