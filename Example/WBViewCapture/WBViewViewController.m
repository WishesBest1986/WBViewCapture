//
//  WBViewViewController.m
//  WBViewCapture_Example
//
//  Created by LIJUN on 2017/9/28.
//  Copyright © 2017年 WishesBest1986. All rights reserved.
//

#import "WBViewViewController.h"
#import <WBViewCapture/WBViewCapture.h>
#import "WBImageViewController.h"

@interface WBViewViewController ()

@end

@implementation WBViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Capture" style:UIBarButtonItemStylePlain target:self action:@selector(captureBtnClicked:)];
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
    [self.navigationController.view capture:^(UIImage * _Nullable caputuredImage) {
        NSLog(@"%@", caputuredImage);
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        WBImageViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"imageViewController"];
        viewController.image = caputuredImage;
        [self.navigationController pushViewController:viewController animated:YES];
    }];
}

@end
