

ifneq (1,$(RULES))

PYDEV_VERSION = 6.2.0
PYDEV_ZIP = PyDev%20$(PYDEV_VERSION)
PYDEV_URL = https://sourceforge.net/projects/pydev/files/pydev/PyDev%20$(PYDEV_VERSION)/PyDev%20$(PYDEV_VERSION).zip/download
PYDEV_DIR = $(BUILD_TOOLS_DIR)/pydev
PYDEV_REPOS = $(call ECLIPSE_REPOSITORY_URL,$(PYDEV_DIR))

PYDEV_FEATURES := org.python.pydev.feature.feature.group

else

$(BUILD_TOOLS_DIR)/pydev.unpack : $(PACKAGES_DIR)/$(PYDEV_ZIP)
	$(Q)if test ! -d `dirname $@`; then mkdir -p `dirname $@`; fi
	$(Q)rm -rf $(PYDEV_DIR)
	$(Q)mkdir -p $(PYDEV_DIR)
	$(Q)cd $(PYDEV_DIR) ; $(UNZIP) $^
	$(Q)touch $@
	
pydev.install : $(BUILD_TOOLS_DIR)/pydev.unpack 
	$(Q)$(call ECLIPSE_INSTALL_IU, $(PYDEV_FEATURES), $(PYDEV_REPOS), \
		PYDEV, $(PARENT_DIR_A))
	$(Q)touch $@
	
$(PACKAGES_DIR)/$(PYDEV_ZIP) : 
	$(Q)if test ! -d `dirname $@`; then mkdir -p `dirname $@`; fi
	$(Q)wget -O $@ $(PYDEV_URL)

endif
