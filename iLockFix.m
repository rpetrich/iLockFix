#import <SpringBoard/SpringBoard.h>
#import <CaptainHook/CaptainHook.h>
#import <QuartzCore/QuartzCore.h>

#include <dlfcn.h>

CHDeclareClass(SBAwayController);

// Yes, this is a mess
CHOptimizedMethod(0, self, SBAwayView *, SBAwayController, awayView)
{
	SBAwayView *awayView = CHSuper(0, SBAwayController, awayView);
	for (UIView *containerView in awayView.subviews) {
		if ([containerView isKindOfClass:objc_getClass("PLContainerView")]) {
			CGSize awayViewSize = awayView.bounds.size;
			CGRect frame = containerView.frame;
			frame.size.width = awayViewSize.width;
			frame.origin.y = awayViewSize.height - frame.size.height;
			containerView.frame = frame;
			containerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
			for (UIView *subview in containerView.subviews) {
				if ([subview isKindOfClass:[UIImageView class]]) {
					CGRect imageFrame;
					imageFrame.origin.x = 0.0f;
					imageFrame.origin.y = 0.0f;
					imageFrame.size = containerView.size;
					subview.frame = imageFrame;
					subview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
					CGRect contentsCenter;
					contentsCenter.origin.x = 0.1f;
					contentsCenter.origin.y = 0.1f;
					contentsCenter.size.width = 0.8f;
					contentsCenter.size.height = 0.8f;
					subview.layer.contentsCenter = contentsCenter;
				} else if ([subview isKindOfClass:objc_getClass("PLMainView")]) {
					CGRect mainFrame = subview.frame;
					mainFrame.origin.x = (NSInteger)((frame.size.width - mainFrame.size.width) * 0.5f);
					subview.frame = mainFrame;
					subview.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
				} else if ([subview isKindOfClass:[UILabel class]]) {
					CGRect labelFrame = subview.frame;
					labelFrame.origin.x = 0.0f;
					labelFrame.size.width = frame.size.width;
					subview.frame = labelFrame;
					subview.autoresizingMask = UIViewAutoresizingFlexibleWidth;
					if ([(UILabel *)subview textAlignment] != UITextAlignmentCenter)
						[(UILabel *)subview setTextAlignment:UITextAlignmentCenter];
				}
			}
		}
	}
	return awayView;
}

CHConstructor {
	CHLoadLateClass(SBAwayController);
	CHHook(0, SBAwayController, awayView);
}