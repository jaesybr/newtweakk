INSTALL_TARGET_PROCESSES = RobloxMobile
ARCHS = arm64
TARGET = iphone:clang::13.0
DEBUG = 0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = FloatingIconTweak

FloatingIconTweak_FILES = Tweak.x

include $(THEOS_MAKE_PATH)/tweak.mk
