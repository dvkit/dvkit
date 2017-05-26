

ifneq (1,$(RULES))

ECLIPSE_JDT_ZIP = org.eclipse.jdt-$(ECLIPSE_VERSION).zip
ECLIPSE_JDT_URL = $(ECLIPSE_URL)/$(ECLIPSE_JDT_ZIP)
ECLIPSE_JDT_DIR = $(BUILD_TOOLS_DIR)/jdt

ECLIPSE_JDT_FEATURES := org.eclipse.jdt.feature.group

else

jdt.install : $(BUILD_TOOLS_DIR)/jdt.unpack

$(BUILD_TOOLS_DIR)/jdt.unpack : $(PACKAGES_DIR)/$(ECLIPSE_JDT_ZIP)
	$(Q)if test ! -d `dirname $@`; then mkdir -p `dirname $@`; fi
	$(Q)rm -rf $(ECLIPSE_JDT_DIR)
	$(Q)mkdir -p $(ECLIPSE_JDT_DIR)
	$(Q)cd $(ECLIPSE_JDT_DIR) ; unzip $^
	$(Q)touch $@
	
jdt.install : $(BUILD_TOOLS_DIR)/jdt.unpack
	$(Q)$(call ECLIPSE_INSTALL_IU, $(ECLIPSE_JDT_FEATURES), \
		$(call ECLIPSE_REPOSITORY_URL,$(ECLIPSE_JDT_DIR)), \
		ECLIPSE_JDT, $(PARENT_DIR_A))
	$(Q)touch $@
	
$(PACKAGES_DIR)/$(ECLIPSE_JDT_ZIP) : 
	$(Q)if test ! -d `dirname $@`; then mkdir -p `dirname $@`; fi
	$(Q)wget -O $@ $(ECLIPSE_JDT_URL)

endif
