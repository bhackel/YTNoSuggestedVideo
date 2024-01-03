TARGET := iphone:clang:latest:14.0
PACKAGE_VERSION = 1.0
INSTALL_TARGET_PROCESSES = YouTube


include $(THEOS)/makefiles/common.mk

TWEAK_NAME = YTNoSuggestedVideo

$(TWEAK_NAME)_FILES = YTNoSuggestedVideo.x YTNoSuggestedVideoSettings.x
$(TWEAK_NAME)_CFLAGS = -fobjc-arc
$(TWEAK_NAME)_FRAMEWORKS = UIKit

include $(THEOS_MAKE_PATH)/tweak.mk
