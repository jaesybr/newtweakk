#import <UIKit/UIKit.h>

@interface RBWebHomeViewController : UIViewController

- (void)injectFloatingIcon;

@end

%hook RBWebHomeViewController

- (void)viewDidLoad {
    %orig;
    
    [self injectFloatingIcon];
}

%new
- (void)injectFloatingIcon {
    NSLog(@"Adding a floating icon...");
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (@available(iOS 13.0, *)) {
            UIWindowScene *windowScene = (UIWindowScene *)[UIApplication sharedApplication].connectedScenes.allObjects.firstObject;
            if (windowScene) {
                UIWindow *keyWindow = windowScene.windows.firstObject;
                if (keyWindow && keyWindow.rootViewController == self) {
                    NSLog(@"Found the main view controller. Adding the floating icon.");
                    UIView *floatingIcon = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 50, 50)];
                    floatingIcon.backgroundColor = [UIColor redColor];
                    floatingIcon.layer.cornerRadius = 25;
                    floatingIcon.layer.masksToBounds = YES;
                    
                    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconTapped)];
                    [floatingIcon addGestureRecognizer:tapGesture];
                    
                    [keyWindow addSubview:floatingIcon];
                    NSLog(@"Floating icon successfully added to the view.");
                } else {
                    NSLog(@"Unable to find the main view controller.");
                }
            }
        }
    });
}

%new
- (void)iconTapped {
    NSLog(@"The floating icon was tapped!");
}

%end
