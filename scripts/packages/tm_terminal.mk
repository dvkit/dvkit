

ifneq (1,$(RULES))

TM_TERMINAL_VERSION = 4.3
TM_TERMINAL_ZIP = org.eclipse.tm.terminal.repo.zip
TM_TERMINAL_URL = $(ECLIPSE_MIRROR_URL)/tm/terminal/updates/$(TM_TERMINAL_VERSION)/GA/$(TM_TERMINAL_ZIP)
TM_TERMINAL_DIR = $(BUILD_TOOLS_DIR)/tm_terminal

TM_TERMINAL_CTRL_FEATURES := org.eclipse.tm.terminal.control.feature.feature.group
TM_TERMINAL_FEATURES := org.eclipse.tm.terminal.control.feature.feature.group,org.eclipse.tm.terminal.connector.ssh.feature.feature.group,org.eclipse.tm.terminal.connector.local.feature.feature.group,org.eclipse.tm.terminal.view.feature.feature.group,org.eclipse.tm.terminal.feature.feature.group

TM_TERMINAL_REPOS = $(call ECLIPSE_REPOSITORY_URL,$(TM_TERMINAL_DIR)),$(call ECLIPSE_REPOSITORY_URL,$(ORBIT_DIR)),$(call ECLIPSE_REPOSITORY_URL,$(ECLIPSE_PLATFORM_DIR))

TM_TERMINAL_DEPS := \
	$(BUILD_TOOLS_DIR)/tm_terminal.unpack \
	$(BUILD_TOOLS_DIR)/orbit.unpack \
	$(BUILD_TOOLS_DIR)/eclipse_platform.unpack 

else

$(BUILD_TOOLS_DIR)/tm_terminal.unpack : $(PACKAGES_DIR)/$(TM_TERMINAL_ZIP)
	$(Q)if test ! -d `dirname $@`; then mkdir -p `dirname $@`; fi
	$(Q)rm -rf $(TM_TERMINAL_DIR)
	$(Q)mkdir -p $(TM_TERMINAL_DIR)
	$(Q)cd $(TM_TERMINAL_DIR) ; unzip $^
	$(Q)touch $@
	
tm_terminal_ctrl.install : $(TM_TERMINAL_DEPS) 
	$(Q)$(call ECLIPSE_INSTALL_IU, $(TM_TERMINAL_CTRL_FEATURES), \
		$(TM_TERMINAL_REPOS), TM_TERMINAL_CTRL, $(PARENT_DIR_A))
	$(Q)touch $@
	
tm_terminal.install : $(TM_TERMINAL_DEPS)
	$(Q)$(call ECLIPSE_INSTALL_IU, $(TM_TERMINAL_FEATURES), \
		$(TM_TERMINAL_REPOS), TM_TERMINAL, $(PARENT_DIR_A))
	$(Q)touch $@
	
$(PACKAGES_DIR)/$(TM_TERMINAL_ZIP) : 
	$(Q)if test ! -d `dirname $@`; then mkdir -p `dirname $@`; fi
	$(Q)wget -O $@ $(TM_TERMINAL_URL)

endif
