#import <sys/utsname.h>
#import <rootless.h>
#import "YTNoSuggestedVideo.h"


void YTNSV_showSnackBar(NSString *text);
NSBundle *YTNSV_getTweakBundle();


%group YTNSV_Tweak
    // Overwrite the method that checks if the endscreen should be shown
    %hook YTMainAppVideoPlayerOverlayViewController
    - (bool)shouldShowAutonavEndscreen {
        if (IS_TWEAK_ENABLED) {
            return false;
        }
        return %orig;
    }
    %end
%end


%ctor {
    %init(YTNSV_Tweak);
}


// Helper methods for tweak settings
void YTNSV_showSnackBar(NSString *text) {
    YTHUDMessage *message = [%c(YTHUDMessage) messageWithText:text];
    GOOHUDManagerInternal *manager = [%c(GOOHUDManagerInternal) sharedInstance];
    [manager showMessageMainThread:message];
}

NSBundle *YTNSV_getTweakBundle() {
    static NSBundle *bundle = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"YTNoSuggestedVideo" ofType:@"bundle"];
        if (bundlePath)
            bundle = [NSBundle bundleWithPath:bundlePath];
        else // Rootless
            bundle = [NSBundle bundleWithPath:ROOT_PATH_NS(@"/Library/Application Support/YTNoSuggestedVideo.bundle")];
    });
    return bundle;
}
