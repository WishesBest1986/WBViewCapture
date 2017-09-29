//
//  WKWebView+Capture.m
//  WBViewCapture
//
//  Created by LIJUN on 2017/9/29.
//

#import "WKWebView+Capture.h"

@implementation WKWebView (Capture)

#pragma mark - Private Method

- (void)contentPageDraw:(UIView *)targetView index:(NSInteger)index maxIndex:(NSInteger)maxIndex drawCallback:(void (^)(void))callback
{
    CGRect splitFrame = CGRectMake(0, index * targetView.frame.size.height, targetView.bounds.size.width, targetView.frame.size.height);
    
    CGRect myFrame = self.frame;
    myFrame.origin.y = - (index * targetView.frame.size.height);
    self.frame = myFrame;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [targetView drawViewHierarchyInRect:splitFrame afterScreenUpdates:YES];
        
        if (index < maxIndex) {
            [self contentPageDraw:targetView index:index + 1 maxIndex:maxIndex drawCallback:callback];
        } else {
            callback();
        }
    });
}

- (void)contentCaptureWithoutOffset:(void (^)(UIImage * _Nullable))completion
{
    UIView *containerView = [[UIView alloc] initWithFrame:self.bounds];
    
    CGRect bakFrame = self.frame;
    UIView *bakSuperView = self.superview;
    NSInteger bakIndex = [self.superview.subviews indexOfObject:self];
    
    [self removeFromSuperview];
    [containerView addSubview:self];
    
    CGSize totalSize = self.scrollView.contentSize;
    
    NSInteger page = floorf(totalSize.height / containerView.bounds.size.height);
    self.frame = CGRectMake(0, 0, containerView.bounds.size.width, self.scrollView.contentSize.height);
    
    UIGraphicsBeginImageContextWithOptions(totalSize, NO, [UIScreen mainScreen].scale);
    [self contentPageDraw:containerView index:0 maxIndex:page drawCallback:^{
        UIImage *capturedImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        [self removeFromSuperview];
        [bakSuperView insertSubview:self atIndex:bakIndex];
        self.frame = bakFrame;
        
        [containerView removeFromSuperview];
        
        completion(capturedImage);
    }];
}

- (void)contentScrollPageDraw:(NSInteger)index maxIndex:(NSInteger)maxIndex drawCallback:(void (^)(void))callback
{
    [self.scrollView setContentOffset:CGPointMake(0, index * self.scrollView.frame.size.height) animated:NO];
    CGRect splitFrame = CGRectMake(0, index * self.scrollView.frame.size.height, self.bounds.size.width, self.bounds.size.height);
    
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
    CGPoint bakOffset = self.scrollView.contentOffset;
    
    UIView *snapShotView = [self snapshotViewAfterScreenUpdates:NO];
    snapShotView.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, snapShotView.frame.size.width, snapShotView.frame.size.height);
    [self.superview addSubview:snapShotView];
    
    if (self.frame.size.height < self.scrollView.contentSize.height) {
        self.scrollView.contentOffset = CGPointMake(0, self.scrollView.contentSize.height - self.frame.size.height);
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.scrollView.contentOffset = CGPointZero;

        [self contentCaptureWithoutOffset:^(UIImage * _Nullable capturedImage) {
            self.scrollView.contentOffset = bakOffset;
            [snapShotView removeFromSuperview];
            completion(capturedImage);
        }];
    });
}

- (void)contentScrollCapture:(void (^)(UIImage * _Nullable))completion
{
    UIView *snapShotView = [self snapshotViewAfterScreenUpdates:NO];
    snapShotView.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, snapShotView.frame.size.width, snapShotView.frame.size.height);
    [self.superview addSubview:snapShotView];
    
    CGPoint bakOffset = self.scrollView.contentOffset;
    
    NSInteger page = floorf(self.scrollView.contentSize.height / self.bounds.size.height);
    
    UIGraphicsBeginImageContextWithOptions(self.scrollView.contentSize, NO, [UIScreen mainScreen].scale);
    
    [self contentScrollPageDraw:0 maxIndex:page drawCallback:^{
        UIImage *capturedImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        [self.scrollView setContentOffset:bakOffset animated:NO];
        [snapShotView removeFromSuperview];
        
        completion(capturedImage);
    }];
}

@end
