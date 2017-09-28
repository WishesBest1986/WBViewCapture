//
//  WBTableViewController.m
//  WBViewCapture_Example
//
//  Created by LIJUN on 2017/9/28.
//  Copyright © 2017年 WishesBest1986. All rights reserved.
//

#import "WBTableViewController.h"

@interface WBTableViewController ()

@end

@implementation WBTableViewController

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
    
}

@end
