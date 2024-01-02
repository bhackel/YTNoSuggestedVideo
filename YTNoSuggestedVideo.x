#import <UIKit/UIKit.h>

@interface YTMainAppVideoPlayerOverlayViewController : UIViewController
- (bool)shouldShowAutonavEndscreen;
@end

%hook YTMainAppVideoPlayerOverlayViewController

- (bool)shouldShowAutonavEndscreen {
    return false;
}

%end