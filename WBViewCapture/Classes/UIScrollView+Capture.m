//
//  UIScrollView+Capture.m
//  WBViewCapture
//
//  Created by LIJUN on 2017/9/28.
//

#import "UIScrollView+Capture.h"
#import "UIView+Capture.h"
#import <objc/runtime.h>

@implementation UIScrollView (Capture)

#pragma mark - Private Method

- (void)renderImageView:(void (^)(UIImage * _Nullable))completion
{
    // rebuild scrollView superView and their hod relationShip
    UIView *tempRenderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.contentSize.width, self.contentSize.height)];
    [self removeFromSuperview];
    [tempRenderView addSubview:self];
    
    self.contentOffset = CGPointZero;
    self.frame = tempRenderView.bounds;
    
    // swizzling setFrame
    Method method = class_getInstanceMethod(object_getClass(self), @selector(setFrame:));
    Method swizzledMethod = class_getInstanceMethod(object_getClass(self), @selector(setFrameSwizzled:));
    method_exchangeImplementations(method, swizzledMethod);
    
    // sometimes scrollView will capture nothing without defer
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIImage *capturedImage = nil;

        UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
        CGContextRef context = UIGraphicsGetCurrentContext();
        if ([self isContainWKWebView]) {
            [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
        } else {
            [self.layer renderInContext:context];
        }
        capturedImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        method_exchangeImplementations(swizzledMethod, method);
        
        completion(capturedImage);
    });
}

- (void)contentScrollPageDraw:(NSInteger)index maxIndex:(NSInteger)maxIndex drawCallback:(void (^)(void))callback
{
    [self setContentOffset:CGPointMake(0, index * self.frame.size.height) animated:NO];
    CGRect splitFrame = CGRectMake(0, index * self.frame.size.height, self.bounds.size.width, self.bounds.size.height);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self drawViewHierarchyInRect:splitFrame afterScreenUpdates:YES];
        
        if (index < maxIndex) {
            [self contentScrollPageDraw:index + 1 maxIndex:maxIndex drawCallback:callback];
        } else {
            callback();
        }
    });
}

#pragma mark - Public Method

- (void)contentCapture:(void (^)(UIImage * _Nullable))completion
{
    // put a fake cover of view
    UIView *snapShotView = [self snapshotViewAfterScreenUpdates:NO];
    snapShotView.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, snapShotView.frame.size.width, snapShotView.frame.size.height);
    [self.superview addSubview:snapShotView];
    
    // backup all properties of scrollView if needed.
    CGRect bakFrame = self.frame;
    CGPoint bakOffset = self.contentOffset;
    UIView *bakSuperView = self.superview;
    NSInteger bakIndex = [self.superview.subviews indexOfObject:self];
    
    // scroll to bottom show all cached view
    if (self.frame.size.height < self.contentSize.height) {
        self.contentOffset = CGPointMake(0, self.contentSize.height - self.frame.size.height);
    }
    
    [self renderImageView:^(UIImage * _Nullable capturedImage) {
        [self removeFromSuperview];
        self.frame = bakFrame;
        self.contentOffset = bakOffset;
        [bakSuperView insertSubview:self atIndex:bakIndex];
        [snapShotView removeFromSuperview];
        
        completion(capturedImage);
    }];
}

- (void)contentScrollCapture:(void (^)(UIImage * _Nullable))completion
{
    // put a fake cover of view
    UIView *snapShotView = [self snapshotViewAfterScreenUpdates:NO];
    snapShotView.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, snapShotView.frame.size.width, snapShotView.frame.size.height);
    [self.superview addSubview:snapShotView];
    
    // backup all properties of scrollView if needed.
    CGPoint bakOffset = self.contentOffset;
    
    NSInteger page = floorf(self.contentSize.height / self.bounds.size.height);
    
    UIGraphicsBeginImageContextWithOptions(self.contentSize, NO, [UIScreen mainScreen].scale);
    [self contentScrollPageDraw:0 maxIndex:page drawCallback:^{
        UIImage *capturedImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        [self setContentOffset:bakOffset animated:NO];
        [snapShotView removeFromSuperview];
        
        completion(capturedImage);
    }];
}

@end
