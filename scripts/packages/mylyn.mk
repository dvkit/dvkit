

ifneq (1,$(RULES))

MYLYN_VERSION = 3.24.0
MYLYN_DOCS_VERSION = 3.0.23
MYLYN_ZIP = mylyn-$(MYLYN_VERSION).v20170705-2102.zip
MYLYN_DOCS_ZIP = mylyn_docs-$(MYLYN_DOCS_VERSION).zip
MYLYN_URL = $(ECLIPSE_MIRROR_URL)/mylyn/drops/$(MYLYN_VERSION)/v20170705-2102/$(MYLYN_ZIP)
MYLYN_DOCS_URL = $(ECLIPSE_MIRROR_URL)/mylyn/docs/releases/$(MYLYN_DOCS_VERSION)
MYLYN_DIR = $(BUILD_TOOLS_DIR)/mylyn
MYLYN_DOCS_DIR = $(BUILD_TOOLS_DIR)/mylyn_docs
MYLYN_REPOS = $(call ECLIPSE_REPOSITORY_URL,$(MYLYN_DIR)),$(call ECLIPSE_REPOSITORY_URL,$(MYLYN_DOCS_DIR)),$(call ECLIPSE_REPOSITORY_URL,$(ECLIPSE_PLATFORM_DIR))

MYLYN_FEATURES := org.eclipse.mylyn_feature.feature.group,org.eclipse.mylyn.wikitext_feature.feature.group,org.eclipse.mylyn.wikitext.editors_feature.feature.group,org.eclipse.mylyn.htmltext.feature.group,org.eclipse.mylyn.wikitext.extras_feature.feature.group,org.eclipse.mylyn.docs.epub.feature.group


else

$(BUILD_TOOLS_DIR)/mylyn.unpack : $(PACKAGES_DIR)/$(MYLYN_ZIP)
	$(Q)if test ! -d `dirname $@`; then mkdir -p `dirname $@`; fi
	$(Q)rm -rf $(MYLYN_DIR)
	$(Q)mkdir -p $(MYLYN_DIR)
	$(Q)cd $(MYLYN_DIR) ; $(UNZIP) $^
	$(Q)touch $@

$(BUILD_TOOLS_DIR)/mylyn-docs.unpack : $(PACKAGES_DIR)/$(MYLYN_DOCS_ZIP)
	$(Q)if test ! -d `dirname $@`; then mkdir -p `dirname $@`; fi
	$(Q)rm -rf $(MYLYN_DOCS_DIR)
	$(Q)mkdir -p $(MYLYN_DOCS_DIR)
	$(Q)cd $(MYLYN_DOCS_DIR) ; $(UNZIP) $^
	$(Q)touch $@
	
mylyn.install : \
	$(BUILD_TOOLS_DIR)/mylyn.unpack \
	$(BUILD_TOOLS_DIR)/mylyn-docs.unpack \
	gef.install launchbar.install tm_terminal_ctrl.install
	$(Q)$(call ECLIPSE_INSTALL_IU, $(MYLYN_FEATURES), $(MYLYN_REPOS), \
		MYLYN, $(PARENT_DIR_A))
	$(Q)touch $@
	
$(PACKAGES_DIR)/$(MYLYN_ZIP) : 
	$(Q)if test ! -d `dirname $@`; then mkdir -p `dirname $@`; fi
	$(Q)wget -O $@ $(MYLYN_URL)

$(PACKAGES_DIR)/$(MYLYN_DOCS_ZIP) : 
	$(Q)if test ! -d `dirname $@`; then mkdir -p `dirname $@`; fi
	$(Q)rm -rf $(PACKAGES_DIR)/mylyn_docs
	$(Q)$(call ECLIPSE_MIRROR_REPO,$(MYLYN_DOCS_URL),$(PACKAGES_DIR)/mylyn_docs)
	$(Q)cd $(PACKAGES_DIR)/mylyn_docs ; $(ZIP) -r $@ *
	$(Q)rm -rf $(PACKAGES_DIR)/mylyn_docs

endif
