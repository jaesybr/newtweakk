ARCHS = arm64
TARGET := iphone:clang:latest:7.0
INSTALL_TARGET_PROCESSES = '_'


include $(THEOS)/makefiles/common.mk

TWEAK_NAME = newtweakk

newtweakk_FILES = Tweak.x
newtweakk_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
