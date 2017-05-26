
DVKIT_SCRIPTS_DIR := $(dir $(lastword $(MAKEFILE_LIST)))
DVKIT_SCRIPTS_DIR := $(shell cd $(DVKIT_SCRIPTS_DIR) ; pwd)
DVKIT_DIR := $(shell cd $(DVKIT_SCRIPTS_DIR)/.. ; pwd)

BUILD_DIR := $(DVKIT_DIR)/build
PACKAGES_DIR := $(DVKIT_DIR)/packages

ECLIPSESCRIPTS_PKGS_DIRS += $(DVKIT_SCRIPTS_DIR)/packages

MK_INCLUDES += $(DVKIT_SCRIPTS_DIR)/dvkit.mk
include $(DVKIT_SCRIPTS_DIR)/eclipsescripts/mkfiles/eclipsescripts.mk
