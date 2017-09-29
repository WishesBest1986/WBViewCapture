//
//  WKWebView+Capture.h
//  WBViewCapture
//
//  Created by LIJUN on 2017/9/29.
//

#import <WebKit/WebKit.h>

@interface WKWebView (Capture)

- (void)contentCapture:(void (^_Nullable)(UIImage * _Nullable caputuredImage))completion;
- (void)contentScrollCapture:(void (^_Nullable)(UIImage * _Nullable caputuredImage))completion;

@end
