//
//     Generated by class-dump 3.5 (64 bit).
//
//  Copyright (C) 1997-2019 Steve Nygard.
//

#import "NSObject-Protocol.h"

@class RBBaseViewController;

@protocol RBBaseViewControllerLifecycleObserver <NSObject>

@optional
- (void)rbViewControllerDidDisappear:(RBBaseViewController *)arg1;
- (void)rbViewControllerWillDisappear:(RBBaseViewController *)arg1;
- (void)rbViewControllerDidAppear:(RBBaseViewController *)arg1;
- (void)rbViewControllerWillAppear:(RBBaseViewController *)arg1;
@end
