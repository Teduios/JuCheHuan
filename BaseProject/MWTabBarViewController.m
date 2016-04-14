//
//  MWTabBarViewController.m
//  My world
//
//  Created by tarena on 15/12/21.
//  Copyright © 2015年 tarena. All rights reserved.
//
#import "MWTabBarViewController.h"
#import "MWWelcomeViewController.h"
#import "MWFirstPageViewController.h"
#import "MWSecondViewController.h"
#import "ViewController.h"
#import "CustomLayout.h"
@interface MWTabBarViewController ()

@end

@implementation MWTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    MWFirstPageViewController *firstPage = [[MWFirstPageViewController alloc] init];
    UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:firstPage];
    
    MWSecondViewController *secondPage = [[MWSecondViewController alloc] init];
    UINavigationController *secondNav = [[UINavigationController alloc] initWithRootViewController:secondPage];
    
    
    CustomLayout *layout = [[CustomLayout alloc]init];
    ViewController *vc = [[ViewController alloc]initWithCollectionViewLayout:layout];
    
    UINavigationController *otherNav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    self.viewControllers = @[firstNav, secondNav, otherNav];
    
    
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
