//
//  WBWebViewController.m
//  WBViewCapture_Example
//
//  Created by LIJUN on 2017/9/28.
//  Copyright © 2017年 WishesBest1986. All rights reserved.
//

#import "WBWebViewController.h"
#import <WBViewCapture/WBViewCapture.h>
#import "WBImageViewController.h"

@interface WBWebViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation WBWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Capture" style:UIBarButtonItemStylePlain target:self action:@selector(captureBtnClicked:)];
    
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
    [self.webView contentCapture:^(UIImage * _Nullable caputuredImage) {
        NSLog(@"%@", caputuredImage);
        UIImageWriteToSavedPhotosAlbum(caputuredImage, self, nil, nil);
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        WBImageViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"imageViewController"];
        viewController.image = caputuredImage;
        [self.navigationController pushViewController:viewController animated:YES];
    }];
}

@end
