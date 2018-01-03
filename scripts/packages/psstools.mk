

ifneq (1,$(RULES))

PSSTOOLS_VERSION = 0.0.1
PSSTOOLS_ZIP = psstools-$(PSSTOOLS_VERSION).jar
PSSTOOLS_URL = https://sourceforge.net/projects/psstools/files/release/$(PSSTOOLS_VERSION)/$(PSSTOOLS_ZIP)/download
PSSTOOLS_DIR = $(BUILD_TOOLS_DIR)/psstools
PSSTOOLS_REPOS = $(call ECLIPSE_REPOSITORY_URL,$(PSSTOOLS_DIR))

PSSTOOLS_FEATURES := net.sf.psstools.lang.feature.feature.group

else

$(BUILD_TOOLS_DIR)/psstools.unpack : $(PACKAGES_DIR)/$(PSSTOOLS_ZIP)
	$(Q)if test ! -d `dirname $@`; then mkdir -p `dirname $@`; fi
	$(Q)rm -rf $(PSSTOOLS_DIR)
	$(Q)mkdir -p $(PSSTOOLS_DIR)
	$(Q)cd $(PSSTOOLS_DIR) ; unzip $^
	$(Q)touch $@
	
psstools.install : $(BUILD_TOOLS_DIR)/psstools.unpack xtext.runtime.install
	$(Q)$(call ECLIPSE_INSTALL_IU, $(PSSTOOLS_FEATURES), $(PSSTOOLS_REPOS), \
		PSSTOOLS, $(PARENT_DIR_A))
	$(Q)touch $@
	
$(PACKAGES_DIR)/$(PSSTOOLS_ZIP) : 
	$(Q)if test ! -d `dirname $@`; then mkdir -p `dirname $@`; fi
	$(Q)wget -O $@ $(PSSTOOLS_URL)

endif
