//
//  MWDetailViewController.m
//  My world
//
//  Created by tarena on 15/12/21.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "MWDetailViewController.h"

@interface MWDetailViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation MWDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.hidesBottomBarWhenPushed = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
    self.webView.delegate = self;
    [self.webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebViewDelegate
// 开始加载网页
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    // 设置状态栏(status bar)的activityIndicatorView动画
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}
// 成功加载完毕
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    // 设置状态栏indicatorView动画停止
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    //
}
// 加载失败
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    // 停止动画
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    NSLog(@"加载失败:%@",error.userInfo);
}

@end
