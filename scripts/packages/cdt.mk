

ifneq (1,$(RULES))

CDT_ZIP = org.eclipse.cdt-$(ECLIPSE_VERSION).zip
CDT_URL = $(ECLIPSE_URL)/$(CDT_ZIP)
CDT_DIR = $(BUILD_TOOLS_DIR)/cdt

CDT_FEATURES := org.eclipse.cdt.feature.group

else

cdt.install : $(BUILD_TOOLS_DIR)/cdt.unpack

$(BUILD_TOOLS_DIR)/cdt.unpack : $(PACKAGES_DIR)/$(CDT_ZIP)
	$(Q)if test ! -d `dirname $@`; then mkdir -p `dirname $@`; fi
	$(Q)rm -rf $(CDT_DIR)
	$(Q)mkdir -p $(CDT_DIR)
	$(Q)cd $(CDT_DIR) ; unzip $^
	$(Q)touch $@
	
cdt.install : $(BUILD_TOOLS_DIR)/cdt.unpack
	$(Q)$(call ECLIPSE_INSTALL_IU, $(CDT_FEATURES), \
		$(call ECLIPSE_REPOSITORY_URL,$(CDT_DIR)), \
		CDT, $(PARENT_DIR_A))
	$(Q)touch $@
	
$(PACKAGES_DIR)/$(CDT_ZIP) : 
	$(Q)if test ! -d `dirname $@`; then mkdir -p `dirname $@`; fi
	$(Q)wget -O $@ $(CDT_URL)

endif
