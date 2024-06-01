#import <UIKit/UIKit.h>

@interface RBWebHomeViewController : UIViewController

// Declare the injectFloatingIcon method in the interface
- (void)injectFloatingIcon;

@end

%hook RBWebHomeViewController

- (void)viewDidLoad {
    %orig;
    
    // Call your method to inject the floating icon
    [self injectFloatingIcon];
}

%new
- (void)injectFloatingIcon {
    NSLog(@"injectFloatingIcon method called.");
    
    dispatch_async(dispatch_get_main_queue(), ^{
        // Adding the floating icon to the view
        UIWindowScene *windowScene = (UIWindowScene *)[UIApplication sharedApplication].connectedScenes.allObjects.firstObject;
        UIWindow *keyWindow = windowScene.windows.firstObject;
        
        if ([keyWindow.rootViewController isKindOfClass:[RBWebHomeViewController class]]) {
            NSLog(@"RBWebHomeViewController obtained. Adding floating icon.");
            UIView *floatingIcon = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 50, 50)];
            floatingIcon.backgroundColor = [UIColor redColor];
            floatingIcon.layer.cornerRadius = 25;
            floatingIcon.layer.masksToBounds = YES;
            
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconTapped)];
            [floatingIcon addGestureRecognizer:tapGesture];
            
            [keyWindow addSubview:floatingIcon];
            NSLog(@"Floating icon added to the view.");
        } else {
            NSLog(@"RBWebHomeViewController not found.");
        }
    });
}

%new
- (void)iconTapped {
    NSLog(@"Floating icon tapped!");
}

%end
