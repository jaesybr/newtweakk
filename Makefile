ARCHS = arm64
TARGET := iphone:clang:latest:7.0
INSTALL_TARGET_PROCESSES = com.roblox.robloxmobile

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = newtweakk

newtweakk_FILES = Tweak.x
newtweakk_CFLAGS = -fobjc-arc
newtweakk_FRAMEWORKS = UIKit
newtweakk_PLIST = FloatingIconTweak.plist

include $(THEOS_MAKE_PATH)/tweak.mk
