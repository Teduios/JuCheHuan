//
//  MWFirstPageViewController.m
//  My world
//
//  Created by tarena on 15/12/12.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "MWFirstPageViewController.h"
#import "MWNewsTableViewCell.h"
#import "MWDataTool.h"
#import "MWDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import <MBProgressHUD.h>
#import "SDCycleScrollView.h"

#define kImageCount 5

static NSArray *updateArticleData;

@interface MWFirstPageViewController ()<UITableViewDelegate, UITableViewDataSource,SDCycleScrollViewDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, strong)NSArray *dataArray;
/**新闻数据*/
@property (nonatomic, strong)NSArray *articleData;
/**快报数据*/
@property (nonatomic, strong)NSArray *headlineData;
/**优惠数据*/
@property (nonatomic, strong)NSArray *PreferentialData;

@property (nonatomic, strong)NSArray *updateDataArray;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSArray *newsArray;
@property (nonatomic, strong)UIView *headerView;

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UISegmentedControl *segmented;
// 统计刷新次数
@property (nonatomic, assign) NSInteger updateCount;

@end

#define CArticlePartUrl @"http://c.m.163.com/nc/article/list/T1348654060988/"

@implementation MWFirstPageViewController

// 初始化tabBar
- (instancetype)init {
    self = [super init];
    if (self) {
        self.title = @"资讯";
        self.tabBarItem.image = [[UIImage imageNamed:@"资讯 2"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.tabBarItem.selectedImage = [[UIImage imageNamed:@"01"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return self;
}

- (UIView *)headerView {
    if(_headerView == nil) {
        _headerView = [[UIView alloc] init];
    }
    return _headerView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.updateCount = 0;
    // 获取article数据
    [MWDataTool getArticleDataAndCallback:^(id obj) {
        self.articleData = obj;
        NSLog(@"%@", [NSThread currentThread]);
        [self.tableView reloadData];
        //NSLog(@"obj:%@",obj);
    }];
    
    // 获取news数据
    [MWDataTool getNewsDataAndCallback:^(id obj) {
        self.newsArray = obj;
        //NSLog(@"obj:%@",obj);
        // 添加滚动视图
        [self setUpSmallScrollView];
    }];
    
    // 添加segmentedcontrol
    [self addsegmentedControl];
    
    // 添加tableView
    [self addTableView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self addGoTopButton];
//     [self test];
}

#pragma mark -- 滚动视图
// 添加小的滚动视图，高度为200
- (void)setUpSmallScrollView {
    
    // 添加滚动视图(第三方)
    // 网络加载 --- 创建带标题的图片轮播器
    NSMutableArray *titleArray = [NSMutableArray array];
    NSMutableArray *urlArray = [NSMutableArray array];
    for (int i = 0; i < 5; i++) {
        MWNews *news = self.newsArray[i];
        [titleArray addObject:news.title];
        [urlArray addObject:news.picURL];
    }
    CGFloat w = self.view.bounds.size.width;
    SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, w, 200) delegate:self placeholderImage:[UIImage imageNamed:@"Poppies"]];
    
    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    cycleScrollView2.titlesGroup = titleArray;
    cycleScrollView2.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    cycleScrollView2.autoScrollTimeInterval = 2.5;
    [self.view addSubview:cycleScrollView2];
    cycleScrollView2.imageURLStringsGroup = urlArray;
    
    [self.headerView addSubview:cycleScrollView2];
}


- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", (long)index);
    MWNews *news = self.newsArray[index];
    MWDetailViewController *detailVC = [MWDetailViewController new];
    detailVC.hidesBottomBarWhenPushed = YES;
    detailVC.url = news.contentURL;
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark --- 添加segmentControl
// 向头部视图中添加segmentControl
- (void)addsegmentedControl {
    
    UISegmentedControl *segmented = [[UISegmentedControl alloc]initWithItems:@[@"新闻", @"快报", @"优惠"]];
    self.segmented = segmented;
    segmented.frame = CGRectMake(20, 205, self.view.bounds.size.width - 40, 30);
    segmented.selectedSegmentIndex = 0;
    [segmented addTarget:self action:@selector(changeTableData:) forControlEvents:UIControlEventValueChanged];
    
    [self.headerView addSubview:segmented];
}

- (void)changeTableData:(UISegmentedControl *)seg {
    
    switch (seg.selectedSegmentIndex) {
            
            // 选中segment第一个按钮时，tableView更新数据，显示为article
        case 0:
        {
            self.updateCount = 0;
            MBProgressHUD *progressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            progressHUD.mode = MBProgressHUDModeText;
            progressHUD.labelText = @"正在加载...";
            self.articleData = nil;
            [MWDataTool getArticleDataAndCallback:^(id obj) {
                self.articleData = obj;
                [self.tableView reloadData];
            }];
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            break;
        }
            // 选中segment第二个按钮时，tableView更新数据，显示为headline
        case 1:
        {
            self.updateCount = 0;
            MBProgressHUD *progressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            progressHUD.mode = MBProgressHUDModeText;
            progressHUD.labelText = @"正在加载...";
            self.headlineData = nil;
            [MWDataTool getHeadlineDataAndCallback:^(id obj) {
                self.headlineData = obj;
                NSLog(@"%@", [NSThread currentThread]);
                [self.tableView reloadData];
            }];
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            break;
        }
            // 选中segment第三个按钮时，tableView更新数据，显示为news
        case 2:
        {
            self.updateCount = 0;
            MBProgressHUD *progressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            progressHUD.mode = MBProgressHUDModeText;
            progressHUD.labelText = @"正在加载...";
            self.PreferentialData = nil;
            [MWDataTool getPreferentialNewsDataAndCallback:^(id obj) {
                self.PreferentialData = obj;
                [self.tableView reloadData];
            }];
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            break;
        }
        default:
            break;
    }
    [self.tableView.mj_header endRefreshing];
    [self.tableView reloadData];
}
#pragma mark -- 添加返回头部按钮
- (void)addGoTopButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(self.view.bounds.size.width - 50, self.view.bounds.size.height - 150, 40, 40);
    [button setTitle:@"" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor clearColor];
    UIImage *image = [UIImage imageNamed:@"gotop.png"];
    [button setImage:image forState:UIControlStateNormal];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [button addTarget:self action:@selector(gotopClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)gotopClick:(UIButton *)button {
    NSLog(@"点击动作");
    [self.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
}

#pragma mark -- 添加tableView
// 添加tableView
- (void)addTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 108) style:UITableViewStylePlain];
    // 为tableView添加手势
    UISwipeGestureRecognizer *swipe =[[UISwipeGestureRecognizer alloc] bk_initWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
        UISwipeGestureRecognizer *swipe = (UISwipeGestureRecognizer *)sender;
        swipe.delegate = self;

    }];
    swipe.direction = UISwipeGestureRecognizerDirectionRight | UISwipeGestureRecognizerDirectionLeft | UISwipeGestureRecognizerDirectionUp | UISwipeGestureRecognizerDirectionDown;
    
    [self.tableView addGestureRecognizer:swipe];
    // 注册重用的cell
    [self.tableView registerNib:[UINib nibWithNibName:@"MWNewsTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    self.headerView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 240);
    // 设置头部视图，上有小滚动视图与segmentController
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self changeTableData:self.segmented];
        self.updateCount = 0;
        [self setUpSmallScrollView];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self updateTableViewData];
    }];
    [self.view addSubview:self.tableView];
}

- (void)updateTableViewData {
    
        if (self.segmented.selectedSegmentIndex == 0) {
            self.updateCount += 20;
            NSMutableArray *addData = [NSMutableArray array];
            [addData addObjectsFromArray:self.articleData];
            NSString *url = [NSString stringWithFormat:@"http://c.m.163.com/nc/article/list/T1348654060988/%ld-20.html", self.updateCount];
            updateArticleData = [NSArray array];
            [MWDataTool getArticleDataAndCallback:^(id obj) {
                updateArticleData = obj;
                [addData addObjectsFromArray:updateArticleData];
                self.articleData = [addData copy];
            } withUrl:url];
        }
        if (self.segmented.selectedSegmentIndex == 2) {
            
        }
        if (self.segmented.selectedSegmentIndex == 1) {
            self.updateCount += 1;
            NSMutableArray *addHeadData = [NSMutableArray array];
            [addHeadData addObjectsFromArray:self.headlineData];
            NSString *url = [NSString stringWithFormat:@"http://api.ycapp.yiche.com/appnews/toutiaov51/?platform=1&length=20&page=%ld", self.updateCount + 1];
            __block NSArray *updateArray = [NSArray array];
            [MWDataTool getHeadlineDataAndCallback:^(id obj) {
                updateArray = obj;
                [addHeadData addObjectsFromArray:updateArray];
                self.headlineData = [addHeadData copy];
            } withUrl:url];
            
        }
    [self.tableView.mj_footer endRefreshing];
    [self.tableView reloadData];
}

#pragma mark --- UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // 可修改
    if (self.segmented.selectedSegmentIndex == 0) {
        return self.articleData.count;
    } else if (self.segmented.selectedSegmentIndex == 1) {
        return self.headlineData.count;
    } else {
        return self.PreferentialData.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MWNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    // 接收Cell的数据
    if (self.segmented.selectedSegmentIndex == 0) {
        cell.cellData = self.articleData[indexPath.row];
    } else if (self.segmented.selectedSegmentIndex == 1) {
        cell.cellData = self.headlineData[indexPath.row];
    } else {
        cell.cellData = self.PreferentialData[indexPath.row];
    }
    return cell;
}

// cell的高度设置为80
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // 创建详情页
    MWDetailViewController *detailVC = [MWDetailViewController new];
    // 隐藏详情页的tabBar视图
    detailVC.hidesBottomBarWhenPushed = YES;
    // 接收点击Cell的数据
    if (self.segmented.selectedSegmentIndex == 0) {
        // 设置推出详情页的URL
        MWArticle *article = self.articleData[indexPath.row];
        detailVC.url = article.contentURL;
        [self.navigationController pushViewController:detailVC animated:YES];
    } else if (self.segmented.selectedSegmentIndex == 1) {
        // 添加详情页
        UIViewController *vc = [UIViewController new];
        // 隐藏底部tabBar视图
        vc.view.frame = self.view.bounds;
        vc.hidesBottomBarWhenPushed = YES;
        UIImageView *imageView = [UIImageView new];
        MWHeadline *headLine = self.headlineData[indexPath.row];
        [imageView sd_setImageWithURL:headLine.picURL];
        [vc.view addSubview:imageView];
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        MWPreferentialNews *preferential = self.PreferentialData[indexPath.row];
        detailVC.url = preferential.contentURL;
        [self.navigationController pushViewController:detailVC animated:YES];
    }
    
//    id data = self.dataArray[indexPath.row];
//    if ([data isKindOfClass:[MWArticle class]]) {
//        // 设置推出详情页的URL
//        MWArticle *article = self.dataArray[indexPath.row];
//        detailVC.url = article.contentURL;
//        [self.navigationController pushViewController:detailVC animated:YES];
//    } else if ([data isKindOfClass:[MWHeadline class]]) {
//        // 添加详情页
//        UIViewController *vc = [UIViewController new];
//        // 隐藏底部tabBar视图
//        vc.view.frame = self.view.bounds;
//        vc.hidesBottomBarWhenPushed = YES;
//        UIImageView *imageView = [UIImageView new];
//        MWHeadline *headLine = self.dataArray[indexPath.row];
//        headLine = data;
//        [imageView sd_setImageWithURL:headLine.picURL];
//        [vc.view addSubview:imageView];
//        [self.navigationController pushViewController:vc animated:YES];
//        
//    } else if ([data isKindOfClass:[MWPreferentialNews class]]) {
//        // 设置推出详情页的URL
//        MWPreferentialNews *preferential = self.dataArray[indexPath.row];
//        detailVC.url = preferential.contentURL;
//        [self.navigationController pushViewController:detailVC animated:YES];
//    }
    
}



@end
