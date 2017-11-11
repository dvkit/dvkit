

ifneq (1,$(RULES))

ECLIPSE_PDE_ZIP = org.eclipse.pde-$(ECLIPSE_VERSION).zip
ECLIPSE_PDE_URL = $(ECLIPSE_URL)/$(ECLIPSE_PDE_ZIP)
ECLIPSE_PDE_DIR = $(BUILD_TOOLS_DIR)/pde

ECLIPSE_PDE_FEATURES := org.eclipse.pde.feature.group
ECLIPSE_PDE_REPOS = $(call ECLIPSE_REPOSITORY_URL,$(ECLIPSE_PDE_DIR)),$(call ECLIPSE_REPOSITORY_URL,$(ECLIPSE_PLATFORM_DIR))

else

jdt.install : $(BUILD_TOOLS_DIR)/jdt.unpack

$(BUILD_TOOLS_DIR)/pde.unpack : $(PACKAGES_DIR)/$(ECLIPSE_PDE_ZIP)
	$(Q)if test ! -d `dirname $@`; then mkdir -p `dirname $@`; fi
	$(Q)rm -rf $(ECLIPSE_PDE_DIR)
	$(Q)mkdir -p $(ECLIPSE_PDE_DIR)
	$(Q)cd $(ECLIPSE_PDE_DIR) ; unzip $^
	$(Q)touch $@
	
pde.install : $(BUILD_TOOLS_DIR)/pde.unpack $(BUILD_TOOLS_DIR)/eclipse_platform.unpack jdt.install
	$(Q)$(call ECLIPSE_INSTALL_IU, $(ECLIPSE_PDE_FEATURES), \
		$(ECLIPSE_PDE_REPOS), \
		ECLIPSE_PDE, $(PARENT_DIR_A))
	$(Q)touch $@
	
$(PACKAGES_DIR)/$(ECLIPSE_PDE_ZIP) : 
	$(Q)if test ! -d `dirname $@`; then mkdir -p `dirname $@`; fi
	$(Q)wget -O $@ $(ECLIPSE_PDE_URL)

endif
