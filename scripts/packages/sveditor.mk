

ifneq (1,$(RULES))

SVEDITOR_VERSION = 2.1.4
SVEDITOR_ZIP = sveditor-$(SVEDITOR_VERSION).jar
SVEDITOR_URL = https://sourceforge.net/projects/sveditor/files/sveditor/$(SVEDITOR_VERSION)/$(SVEDITOR_ZIP)/download
SVEDITOR_DIR = $(BUILD_TOOLS_DIR)/sveditor
SVEDITOR_REPOS = $(call ECLIPSE_REPOSITORY_URL,$(SVEDITOR_DIR))

SVEDITOR_FEATURES := net.sf.sveditor.feature.group

else

$(BUILD_TOOLS_DIR)/sveditor.unpack : $(PACKAGES_DIR)/$(SVEDITOR_ZIP)
	$(Q)if test ! -d `dirname $@`; then mkdir -p `dirname $@`; fi
	$(Q)rm -rf $(SVEDITOR_DIR)
	$(Q)mkdir -p $(SVEDITOR_DIR)
	$(Q)cd $(SVEDITOR_DIR) ; $(UNZIP) $^
	$(Q)touch $@
	
sveditor.install : $(BUILD_TOOLS_DIR)/sveditor.unpack gef.install 
	$(Q)$(call ECLIPSE_INSTALL_IU, $(SVEDITOR_FEATURES), $(SVEDITOR_REPOS), \
		SVEDITOR, $(PARENT_DIR_A))
	$(Q)touch $@
	
$(PACKAGES_DIR)/$(SVEDITOR_ZIP) : 
	$(Q)if test ! -d `dirname $@`; then mkdir -p `dirname $@`; fi
	$(Q)wget -O $@ $(SVEDITOR_URL)

endif
