//
//  UIWebView+Capture.h
//  WBViewCapture
//
//  Created by LIJUN on 2017/9/28.
//

#import <UIKit/UIKit.h>

@interface UIWebView (Capture)

- (void)contentCapture:(void (^_Nullable)(UIImage * _Nullable caputuredImage))completion;
- (void)contentScrollCapture:(void (^_Nullable)(UIImage * _Nullable caputuredImage))completion;

@end
