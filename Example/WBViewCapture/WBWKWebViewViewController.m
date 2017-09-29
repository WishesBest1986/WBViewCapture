//
//  WBWKWebViewViewController.m
//  WBViewCapture_Example
//
//  Created by LIJUN on 2017/9/29.
//  Copyright © 2017年 WishesBest1986. All rights reserved.
//

#import "WBWKWebViewViewController.h"
#import <WebKit/WebKit.h>
#import "WBImageViewController.h"
#import <WBViewCapture/WBViewCapture.h>

@interface WBWKWebViewViewController ()

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation WBWKWebViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Capture" style:UIBarButtonItemStylePlain target:self action:@selector(captureBtnClicked:)];
    
    self.webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_webView];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)captureBtnClicked:(id)sender
{
    [self.webView contentScrollCapture:^(UIImage * _Nullable caputuredImage) {
        NSLog(@"%@", caputuredImage);
        UIImageWriteToSavedPhotosAlbum(caputuredImage, self, nil, nil);

        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        WBImageViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"imageViewController"];
        viewController.image = caputuredImage;
        [self.navigationController pushViewController:viewController animated:YES];
    }];
}

@end
