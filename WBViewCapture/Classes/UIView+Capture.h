//
//  UIView+Capture.h
//  WBViewCapture
//
//  Created by LIJUN on 2017/9/22.
//

#import <UIKit/UIKit.h>

@interface UIView (Capture)

- (void)setFrameSwizzled:(CGRect)frame;
- (BOOL)isContainWKWebView;

- (void)capture:(void (^_Nullable)(UIImage * _Nullable caputuredImage))completion;

@end
