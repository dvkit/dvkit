

ifneq (1,$(RULES))

YEDIT_URL=http://dadacoalition.org/yedit
YEDIT_REPOS = $(YEDIT_URL)

YEDIT_FEATURES := org.dadacoalition.yedit.feature.feature.group

else

yedit.install : 
	$(Q)$(call ECLIPSE_INSTALL_IU, $(EPIC_FEATURES), $(YEDIT_REPOS), \
		yEdit, $(PARENT_DIR_A))
	$(Q)touch $@
	
endif
