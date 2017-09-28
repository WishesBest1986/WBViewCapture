//
//  UIView+Capture.m
//  WBViewCapture
//
//  Created by LIJUN on 2017/9/22.
//

#import "UIView+Capture.h"
#import <WebKit/WebKit.h>

@implementation UIView (Capture)

#pragma mark - Public Method

- (void)setFrameSwizzled:(CGRect)frame
{
}

- (BOOL)isContainWKWebView
{
    if ([self isKindOfClass:[WKWebView class]]) {
        return YES;
    }
    for (UIView *view in self.subviews) {
        if ([view isContainWKWebView]) {
            return YES;
        }
    }
    
    return NO;
}

- (void)capture:(void (^)(UIImage * _Nullable))completion
{
    UIImage *capturedImage = nil;
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, -self.frame.origin.x, -self.frame.origin.y);
    if ([self isContainWKWebView]) {
        [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    } else {
        [self.layer renderInContext:context];
    }
    capturedImage = UIGraphicsGetImageFromCurrentImageContext();
    CGContextRestoreGState(context);
    UIGraphicsEndImageContext();
    
    completion(capturedImage);
}

@end
