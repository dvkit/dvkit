
DVKIT_SCRIPTS_DIR := $(dir $(lastword $(MAKEFILE_LIST)))
DVKIT_SCRIPTS_DIR := $(shell cd $(DVKIT_SCRIPTS_DIR) ; pwd)
DVKIT_DIR := $(shell cd $(DVKIT_SCRIPTS_DIR)/.. ; pwd)

BUILD_DIR := $(DVKIT_DIR)/build
PACKAGES_DIR := $(DVKIT_DIR)/packages
DVKIT_ETC_DIR := $(DVKIT_DIR)/etc
WIX_VERSION=311
WIX_ZIP=wix$(WIX_VERSION)-binaries.zip
WIX_URL=https://github.com/wixtoolset/wix3/releases/download/wix$(WIX_VERSION)rtm
WIX_DIR=$(BUILD_DIR)/tools/wix

uname_o := $(shell uname -o)

ECLIPSESCRIPTS_PKGS_DIRS += $(DVKIT_SCRIPTS_DIR)/packages

MK_INCLUDES += $(DVKIT_SCRIPTS_DIR)/dvkit.mk

DVKIT_RESULT_DIR := $(BUILD_DIR)/dvkit/result

include $(DVKIT_SCRIPTS_DIR)/eclipsescripts/mkfiles/eclipsescripts.mk

dvkit_PRODUCT_VERSION := 1.5.0

dvkit-installers : \
	$(DVKIT_RESULT_DIR)/dvkit-$(dvkit_PRODUCT_VERSION)-64.msi \
	$(DVKIT_RESULT_DIR)/dvkit-$(dvkit_PRODUCT_VERSION)-x86.msi
	
DVKIT_RESULT_DIR = $(BUILD_DIR)/dvkit/result

ifeq (Cygwin,$(uname_o))
DVKIT_RESULT_DIR_A := $(shell cygpath -w $(DVKIT_RESULT_DIR) | sed -e 's%\\%/%g')
DVKIT_SCRIPTS_DIR_A := $(shell cygpath -w $(DVKIT_SCRIPTS_DIR) | sed -e 's%\\%/%g')
else
ifeq (Msys,$(uname_o))
DVKIT_RESULT_DIR_A := $(shell echo $(DVKIT_RESULT_DIR) | sed -e 's%^/\([a-zA-Z]\)%\1:%')
DVKIT_SCRIPTS_DIR_A := $(shell echo $(DVKIT_SCRIPTS_DIR) | sed -e 's%^/\([a-zA-Z]\)%\1:%')
else
DVKIT_RESULT_DIR_A := $(DVKIT_RESULT_DIR)
DVKIT_SCRIPTS_DIR_A := $(DVKIT_SCRIPTS_DIR)
endif
endif

$(DVKIT_RESULT_DIR)/dvkit-$(dvkit_PRODUCT_VERSION)-64.msi : dvkit \
	$(BUILD_DIR)/tools/wix.unpack
	$(Q)cd $(DVKIT_RESULT_DIR)/win32.x86_64 ; \
		cscript $(DVKIT_SCRIPTS_DIR_A)/wxigen.js \
			$(DVKIT_RESULT_DIR_A)/win32.x86_64/dvkit-$(dvkit_PRODUCT_VERSION) dvkit_files.wxi
	$(Q)cd $(DVKIT_RESULT_DIR) ; \
		$(WIX_DIR)/candle $(DVKIT_SCRIPTS_DIR_A)/dvkit.wxs \
			-dversion=$(dvkit_PRODUCT_VERSION) \
			-dbasedir=$(DVKIT_RESULT_DIR_A)/win32.x86_64 \
			-detc.dir=$(call NATIVE_PATH,$(DVKIT_ETC_DIR)) \
			-dProgramFilesFolder=ProgramFiles64Folder \
			-darch=x64 \
			-dWin64=yes \
			-ext WixUIExtension
	$(Q)cd $(DVKIT_RESULT_DIR) ; \
		$(WIX_DIR)/light dvkit.wixobj -ext WixUIExtension
	$(Q)cd $(DVKIT_RESULT_DIR) ; rm -rf dvkit.wixobj dvkit.wixpdb
	$(Q)mv $(DVKIT_RESULT_DIR)/dvkit.msi $@
	echo "Build $*"

$(DVKIT_RESULT_DIR)/dvkit-$(dvkit_PRODUCT_VERSION)-x86.msi : dvkit \
	$(BUILD_DIR)/tools/wix.unpack
	$(Q)cd $(DVKIT_RESULT_DIR)/win32.x86 ; \
		cscript $(DVKIT_SCRIPTS_DIR_A)/wxigen.js \
			$(DVKIT_RESULT_DIR_A)/win32.x86/dvkit-$(dvkit_PRODUCT_VERSION) dvkit_files.wxi
	$(Q)cd $(DVKIT_RESULT_DIR) ; \
		$(WIX_DIR)/candle $(DVKIT_SCRIPTS_DIR_A)/dvkit.wxs \
			-dversion=$(dvkit_PRODUCT_VERSION) \
			-dbasedir=$(DVKIT_RESULT_DIR_A)/win32.x86 \
			-detc.dir=$(call NATIVE_PATH,$(DVKIT_ETC_DIR)) \
			-dProgramFilesFolder=ProgramFilesFolder \
			-darch=x86 \
			-dWin64=no \
			-ext WixUIExtension
	$(Q)cd $(DVKIT_RESULT_DIR) ; \
		$(WIX_DIR)/light dvkit.wixobj -ext WixUIExtension
	$(Q)cd $(DVKIT_RESULT_DIR) ; rm -rf dvkit.wixobj dvkit.wixpdb
	$(Q)mv $(DVKIT_RESULT_DIR)/dvkit.msi $@
	echo "Build $*"


$(BUILD_DIR)/tools/wix.unpack : $(PACKAGES_DIR)/$(WIX_ZIP)
	$(Q)if test $ -d `dirname $@`; then mkdir -p `dirname $@`; fi
	$(Q)mkdir -p $(BUILD_DIR)/tools/wix
	$(Q)cd $(BUILD_DIR)/tools/wix ; unzip -o $^
	$(Q)cd $(BUILD_DIR)/tools/wix ; chmod +x *.exe *.dll
	$(Q)touch $@

$(PACKAGES_DIR)/$(WIX_ZIP) :
	if test ! -d `dirname $@`; then mkdir -p `dirname $@`; fi
	wget -O $@ $(WIX_URL)/$(WIX_ZIP)

	
