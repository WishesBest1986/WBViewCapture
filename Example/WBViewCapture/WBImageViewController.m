//
//  WBImageViewController.m
//  WBViewCapture_Example
//
//  Created by LIJUN on 2017/9/28.
//  Copyright © 2017年 WishesBest1986. All rights reserved.
//

#import "WBImageViewController.h"

@interface WBImageViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewHeightConstraint;

@end

@implementation WBImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Display Caputure Image";
    
    self.imageView.contentMode = UIViewContentModeTopLeft;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.imageView.image = self.image;
    self.imageViewWidthConstraint.constant = self.image.size.width;
    self.imageViewHeightConstraint.constant = self.image.size.height;
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

@end
