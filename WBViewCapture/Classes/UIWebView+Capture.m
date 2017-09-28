//
//  UIWebView+Capture.m
//  WBViewCapture
//
//  Created by LIJUN on 2017/9/28.
//

#import "UIWebView+Capture.h"
#import "UIScrollView+Capture.h"

@implementation UIWebView (Capture)

- (void)contentCapture:(void (^)(UIImage * _Nullable))completion
{
    [self.scrollView contentCapture:completion];
}

- (void)contentScrollCapture:(void (^)(UIImage * _Nullable))completion
{
    [self.scrollView contentScrollCapture:completion];
}

@end
