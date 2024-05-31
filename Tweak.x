#import <UIKit/UIKit.h>

@interface UIApplicationDelegate : UIResponder <UIApplicationDelegate>
@end

@interface NSObject (FloatingIcon)
- (void)injectFloatingIcon;
@end

%hook UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    BOOL didFinishLaunching = %orig;
    
    NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
    if ([bundleIdentifier isEqualToString:@"com.roblox.robloxmobile"]) {
        NSLog(@"Roblox detected. Injecting floating icon.");
        [self injectFloatingIcon];
    } else {
        NSLog(@"App is not Roblox.");
    }
    
    return didFinishLaunching;
}

%new
- (void)injectFloatingIcon {
    NSLog(@"injectFloatingIcon method called.");
    
    dispatch_async(dispatch_get_main_queue(), ^{
        UIWindow *keyWindow = [UIApplication sharedApplication].windows.firstObject;
        UIViewController *rootViewController = keyWindow.rootViewController;
        
        if ([rootViewController isKindOfClass:[UIViewController class]]) {
            NSLog(@"Root view controller obtained. Adding floating icon.");
            UIView *floatingIcon = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 50, 50)];
            floatingIcon.backgroundColor = [UIColor redColor];
            floatingIcon.layer.cornerRadius = 25;
            floatingIcon.layer.masksToBounds = YES;
            
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconTapped)];
            [floatingIcon addGestureRecognizer:tapGesture];
            
            [rootViewController.view addSubview:floatingIcon];
            NSLog(@"Floating icon added to the view.");
        } else {
            NSLog(@"Root view controller is not of expected type.");
        }
    });
}

%new
- (void)iconTapped {
    NSLog(@"Floating icon tapped!");
}

%end
