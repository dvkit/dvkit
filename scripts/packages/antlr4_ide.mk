

ifneq (1,$(RULES))

ANTLR4_IDE_URL = https://raw.githubusercontent.com/antlr4ide/antlr4ide-eclipse-release/master

SCALA_IDE_VERSION = 212
SCALA_IDE_ZIP = scala_ide_update.zip
SCALA_IDE_URL = http://download.scala-ide.org/sdk/lithium/e47/scala212/stable/update-site.zip
SCALA_IDE_DIR = $(BUILD_TOOLS_DIR)/scala_ide
SCALA_IDE_REPOS = $(call ECLIPSE_REPOSITORY_URL,$(SCALA_IDE_DIR)/base),$(call ECLIPSE_REPOSITORY_URL,$(ECLIPSE_PLATFORM_DIR))

SCALA_IDE_FEATURES := org.scala-ide.sdt.feature.feature.group

else

$(BUILD_TOOLS_DIR)/scala_ide.unpack : $(PACKAGES_DIR)/$(SCALA_IDE_ZIP)
	$(Q)if test ! -d `dirname $@`; then mkdir -p `dirname $@`; fi
	$(Q)rm -rf $(SCALA_IDE_DIR)
	$(Q)mkdir -p $(SCALA_IDE_DIR)
	$(Q)cd $(SCALA_IDE_DIR) ; $(UNZIP) $^
	$(Q)touch $@
	
scala_ide.install : $(BUILD_TOOLS_DIR)/scala_ide.unpack \
	gef.install launchbar.install tm_terminal_ctrl.install
	$(Q)$(call ECLIPSE_INSTALL_IU, $(SCALA_IDE_FEATURES), $(SCALA_IDE_REPOS), \
		SCALA_IDE, $(PARENT_DIR_A))
	$(Q)touch $@
	
$(PACKAGES_DIR)/$(SCALA_IDE_ZIP) : 
	$(Q)if test ! -d `dirname $@`; then mkdir -p `dirname $@`; fi
	$(Q)wget -O $@ $(SCALA_IDE_URL)

endif
