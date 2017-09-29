#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "UIScrollView+Capture.h"
#import "UIView+Capture.h"
#import "UIWebView+Capture.h"
#import "WBViewCapture.h"
#import "WKWebView+Capture.h"

FOUNDATION_EXPORT double WBViewCaptureVersionNumber;
FOUNDATION_EXPORT const unsigned char WBViewCaptureVersionString[];

