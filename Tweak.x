#import <UIKit/UIKit.h>

%hook UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    BOOL didFinishLaunching = %orig;

    // Check if the app is Roblox
    NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
    if ([bundleIdentifier isEqualToString:@"com.roblox.robloxmobile"]) {
        // Inject floating icon here
        [self injectFloatingIcon];
    }

    return didFinishLaunching;
}

- (void)injectFloatingIcon {
    UIViewController *rootViewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    if ([rootViewController isKindOfClass:[UIViewController class]]) {
        // Create and add the floating icon
        UIView *floatingIcon = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 50, 50)]; // Adjust frame as needed
        floatingIcon.backgroundColor = [UIColor redColor]; // Set background color to red
        floatingIcon.layer.cornerRadius = 25; // Make it a circle
        floatingIcon.layer.masksToBounds = YES;

        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconTapped)];
        [floatingIcon addGestureRecognizer:tapGesture];

        [rootViewController.view addSubview:floatingIcon];
    }
}

- (void)iconTapped {
    // Handle icon tap event
    NSLog(@"Floating icon tapped!");
}

%end
