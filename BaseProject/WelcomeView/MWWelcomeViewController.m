//
//  MWWelcomeViewController.m
//  My world
//
//  Created by tarena on 15/12/18.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "MWWelcomeViewController.h"
#import "MWFirstPageViewController.h"
#import "MWTabBarViewController.h"

@interface MWWelcomeViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIPageControl *pageControl;
@end

@implementation MWWelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [super viewDidLoad];
    
    // 配置滚动视图
    [self setUpScrollView];
    
    [self setUpPageControl];

}

// 配置滚动视图
-(void)setUpScrollView
{
    // 1.创建滚动视图
    UIScrollView *sv = [[UIScrollView alloc]init];
    
    
    // 设置滚动视图的代理为当前控制器，代理就负责响应滚动视图发出的各种消息
    sv.delegate = self;
    
    
    // 2.设置滚动视图的可见区域与控制器的view一样大
    sv.frame = self.view.bounds;
    
    // 3.向滚动视图中添加多个图片子视图
    
    for (int i = 0; i < 4; i++) {
        // 格式化出图片的名称
        NSString *imageName = [NSString stringWithFormat:@"welcome%d.PNG",i+1];
        
        // 创建一个图片视图对象
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
        
        // 设置图片视图的位置及大小
        // 声明了一个结构体的变量，其中x，y和w，h初始化为0
        CGRect iFrame = CGRectZero;
        iFrame.origin = CGPointMake(sv.bounds.size.width * i, 0);//这里bounds与frame相同的效果
        iFrame.size = sv.bounds.size;
        
        imageView.frame = iFrame;
        
        // 将图片视图添加到滚动视图中
        [sv addSubview:imageView];
        
        if (i == 3) {
            // 向此时的最后一屏图片视图中添加按钮
            
            [self addEnterButton:imageView];
            
        }
        
    }
    
    // 4.设置滚动视图的内容大小
    sv.contentSize = CGSizeMake(4 * sv.bounds.size.width, sv.bounds.size.height);
    
    // 设置滚动视图到达边缘时不弹跳
    sv.bounces = NO;
    
    // 配置滚动视图整页滚动
    sv.pagingEnabled = YES;
    
    // 配置滚动视图不显示水平滚动条提示
    sv.showsHorizontalScrollIndicator = NO;
    
    // 5.将滚动视图添加到控制器的view中
    [self.view addSubview:sv];
    
}

// 向图片视图中添加按钮
-(void)addEnterButton:(UIImageView *)iv
{
    // 0.开启图片视图的用户交互功能，否则里面的子视图按钮是不能接收用户的交互的
    iv.userInteractionEnabled = YES;
    
    // 1.创建按钮
    UIButton *button = [[UIButton alloc]init];
    
    // 2.设置按钮的frame
    button.frame = self.view.bounds;
    
    // 按钮的其他配置
    [button setTitle:@"" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor clearColor];
    
    // 3.将按钮添加到图片视图中
    [iv addSubview:button];
    
    // 4.为按钮添加事件响应
    [button addTarget:self action:@selector(enterApp:) forControlEvents:UIControlEventTouchUpInside];
}

// 点击进入应用按钮后，执行的方法
-(void)enterApp:(UIButton *)button
{
    MWTabBarViewController *mainVC = [[MWTabBarViewController alloc]init];
    
    // 获取应用的主window对象，先获取应用程序对象
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    
    // 更换window的跟视图控制器为mainVC，由于welcomeVC不再是window的跟视图控制器了，所以会被释放掉，但是使用present方式切换就不会释放掉welcomeVC
    window.rootViewController = mainVC;
    
}


// 配置分页控件
-(void)setUpPageControl
{
    // 1.创建pageControll的实例
    UIPageControl *pageControl = [[UIPageControl alloc]init];
    
    self.pageControl = pageControl;
    
    // 2.设置pageControl的frame
    pageControl.frame = CGRectMake(0, self.view.bounds.size.height - 40, self.view.bounds.size.width, 30);
    
    // 3.添加pageControl到控制器的view中
    [self.view addSubview:pageControl];
    
    // 4.配置pageControl
    pageControl.numberOfPages = 4;
    
    // 5.配置提示符的颜色
    pageControl.pageIndicatorTintColor = [UIColor blackColor];
    
    // 6.配置选中的提示符的颜色
    pageControl.currentPageIndicatorTintColor = [UIColor yellowColor];
    
    // 7.关闭圆点与用户的交互功能
    pageControl.userInteractionEnabled = NO;
    
    pageControl.currentPage = 0;
    
}

#pragma mark - UIScrollViewDelegate 协议
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // round函数的功能是四舍五入
    int index = round(scrollView.contentOffset.x / self.view.bounds.size.width);
    
    self.pageControl.currentPage = index;
    
    //    NSLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
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
