
PRODUCT := dvkit
PRODUCT_FILE := /net.sf.dvkit.feature/dvkit.product
PRODUCT_SRCDIR := $(DVKIT_DIR)/dvkit
# PRODUCT_FEATURE_DIR := $(PSSTOOLS_DIR)/psstools/features/net.sf.psstools.pssc.feature
PRODUCT_VERSION := 1.5.0
# PRODUCT_PRE_BUILD_TARGETS := $(PRODUCT)_pssc_mw2e
PRODUCT_PKGS += \
	cdt \
	dltk \
	egit \
	emf_rt \
	epic \
	gef \
	jdt \
	pydev \
	scala_ide \
	sveditor \
	tm_terminal \
	vrapper \
	wst \
	jre


include $(ECLIPSESCRIPTS_DIR)/mkfiles/eclipseproduct.mk

ifneq (1,$(RULES))

# ECLIPSE_SDK_PKGS += xtext

else # Rules
$(PRODUCT)_pssc_mw2e : 
	$(Q)$(ECLIPSE_ANT) -buildfile $(call NATIVE_PATH,$(PSSTOOLS_SCRIPTS_DIR)/mw2e_build.xml) \
		-DbuildDirectory=$(call NATIVE_PATH,$($(PRODUCT)_BUILDDIR)/product) build
endif
