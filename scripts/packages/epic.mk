

ifneq (1,$(RULES))

EPIC_URL=http://e-p-i-c.sf.net/updates
EPIC_REPOS = $(EPIC_URL)

EPIC_FEATURES := org.epic.feature.main.feature.group

else

$(BUILD_TOOLS_DIR)/scala_ide.unpack : $(PACKAGES_DIR)/$(SCALA_IDE_ZIP)
	$(Q)if test ! -d `dirname $@`; then mkdir -p `dirname $@`; fi
	$(Q)rm -rf $(SCALA_IDE_DIR)
	$(Q)mkdir -p $(SCALA_IDE_DIR)
	$(Q)cd $(SCALA_IDE_DIR) ; unzip $^
	$(Q)touch $@
	
epic.install : 
	$(Q)$(call ECLIPSE_INSTALL_IU, $(EPIC_FEATURES), $(EPIC_REPOS), \
		EPIC, $(PARENT_DIR_A))
	$(Q)touch $@
	
endif
