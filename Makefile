ARCHS = arm64
TARGET = iphone:clang:16.5:16.5
INSTALL_TARGET_PROCESSES = newtweakk

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = newtweakk

YourTweakName_FILES = Tweak.x
YourTweakName_FRAMEWORKS = UIKit

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
