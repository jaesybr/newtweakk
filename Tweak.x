#import <UIKit/UIKit.h>

@interface UIApplicationDelegate : UIResponder <UIApplicationDelegate>
@end

@interface NSObject (FloatingIcon)
- (void)injectFloatingIcon;
@end

%hook UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    BOOL didFinishLaunching = %orig;
    
    // Check if the app is Roblox
    NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
    if ([bundleIdentifier isEqualToString:@"com.roblox.robloxmobile"]) {
        NSLog(@"Roblox detected. Injecting floating icon.");
        // Inject floating icon here
        [self injectFloatingIcon];
    } else {
        NSLog(@"App is not Roblox.");
    }
    
    return didFinishLaunching;
}

%end

%new
- (void)injectFloatingIcon {
    NSLog(@"injectFloatingIcon method called.");
    
    dispatch_async(dispatch_get_main_queue(), ^{
        // Get the root view controller in a way compatible with iOS 13 and later
        UIWindow *keyWindow = [UIApplication sharedApplication].windows.firstObject;
        UIViewController *rootViewController = keyWindow.rootViewController;
        
        if ([rootViewController isKindOfClass:[UIViewController class]]) {
            NSLog(@"Root view controller obtained. Adding floating icon.");
            // Create and add the floating icon
            UIView *floatingIcon = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 50, 50)]; // Adjust frame as needed
            floatingIcon.backgroundColor = [UIColor redColor]; // Set background color to red
            floatingIcon.layer.cornerRadius = 25; // Make it a circle
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
    // Handle icon tap event
    NSLog(@"Floating icon tapped!");
}

%end
