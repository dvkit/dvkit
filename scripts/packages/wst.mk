

ifneq (1,$(RULES))

WST_VERSION = 3.9.2
WST_ZIP = wtp-repo-R-$(WST_VERSION)-20171201000141.zip
WST_URL = $(ECLIPSE_MIRROR_URL)/webtools/downloads/drops/R$(WST_VERSION)/R-$(WST_VERSION)-20171201000141/$(WST_ZIP)
WST_DIR = $(BUILD_TOOLS_DIR)/wst

WST_FEATURES := org.eclipse.wst.xml_ui.feature.feature.group,org.eclipse.wst.jsdt.feature.feature.group
WST_REPOS = $(call ECLIPSE_REPOSITORY_URL,$(WST_DIR)),$(call ECLIPSE_REPOSITORY_URL,$(ORBIT_DIR)),$(call ECLIPSE_REPOSITORY_URL,$(EQUINOX_DIR))

else

wst.install : $(BUILD_TOOLS_DIR)/wst.unpack jdt.install emf_rt.install

$(BUILD_TOOLS_DIR)/wst.unpack : $(PACKAGES_DIR)/$(WST_ZIP)
	$(Q)if test ! -d `dirname $@`; then mkdir -p `dirname $@`; fi
	$(Q)rm -rf $(WST_DIR)
	$(Q)mkdir -p $(WST_DIR)
	$(Q)cd $(WST_DIR) ; unzip $^
	$(Q)touch $@
	
wst.install : $(BUILD_TOOLS_DIR)/wst.unpack
	$(Q)$(call ECLIPSE_INSTALL_IU, $(WST_FEATURES), \
		$(WST_REPOS), WST, $(PARENT_DIR_A))
	$(Q)touch $@
	
$(PACKAGES_DIR)/$(WST_ZIP) : 
	$(Q)if test ! -d `dirname $@`; then mkdir -p `dirname $@`; fi
	$(Q)wget -O $@ $(WST_URL)

endif
