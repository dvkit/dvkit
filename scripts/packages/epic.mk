

ifneq (1,$(RULES))
EPIC_URL=http://www.epic-ide.org/updates/testing
EPIC_REPOS = $(EPIC_URL)

EPIC_FEATURES := org.epic.feature.main.feature.group

else

epic.install : 
	$(Q)$(call ECLIPSE_INSTALL_IU, $(EPIC_FEATURES), $(EPIC_REPOS), \
		EPIC, $(PARENT_DIR_A))
	$(Q)touch $@
	
endif
