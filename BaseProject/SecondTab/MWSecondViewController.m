//
//  MWSecondViewController.m
//  BaseProject
//
//  Created by CHC on 15/12/21.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "MWSecondViewController.h"
#import "MWDataTool.h"
#import "Header.h"
#import <UIImageView+WebCache.h>
#import "UIScrollView+Refresh.h"
#import "MWVideoTableViewCell.h"
#import "MWDetailViewController.h"


@interface MWSecondViewController () <UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (strong, nonatomic) NSArray * videoArray;
@property (strong, nonatomic) NSArray * judgeArray;
@property (strong, nonatomic) UIScrollView * scrollView;
@property (strong, nonatomic) UITableView * videoTableView; //videoTableView
@property (strong, nonatomic) UITableView * judgeTableView;
@property (strong, nonatomic) UIButton * videoButton;
@property (strong, nonatomic) UIButton * judgeButton;
@property (strong, nonatomic) UIButton * imageButton;

@property (nonatomic, assign) NSInteger updataCount;

@end

@implementation MWSecondViewController

static NSString * const cellIdentifier = @"VideoCell";
static NSString * const nibName = @"MWVideoTableViewCell";

- (instancetype)init {
    if (self = [super init]) {
        self.title = @"评测";
        self.tabBarItem.image = [[UIImage imageNamed:@" 评测 2"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.tabBarItem.selectedImage = [[UIImage imageNamed:@"02"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return self;
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.navigationController.tabBarItem.image = [UIImage imageNamed:@" 评测 2"];
        //self.tabBarItem.selectedImage = [UIImage imageNamed:@"full_bell"];
        // 使用kvc的写法为selectedImage属性赋值
        [self.navigationController.tabBarItem setValue:[UIImage imageNamed:@"Snip20160114_1"] forKeyPath:@"selectedImage"];
    }
    return self;
}

#pragma mark - 划动手势
-(void)addSwipeGestureToView:(UIView *)view withDirection:(UISwipeGestureRecognizerDirection)direction
{
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(leftSwipe)];
    swipeGesture.direction = direction;
    
    [view addGestureRecognizer:swipeGesture];
}
-(void)leftSwipe
{
    self.judgeTableView.hidden = !_judgeTableView.hidden;
    self.tableView.hidden = !_videoTableView.hidden;
    self.videoButton.selected = !_videoButton.selected;
    self.judgeButton.selected = !_judgeButton.selected;
}




#pragma mark - -- video

- (UITableView *)tableView {
    if(_videoTableView == nil) {
        _videoTableView = [[UITableView alloc] init];
        [_videoTableView registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellReuseIdentifier:cellIdentifier];

        _videoTableView.delegate = self;
        _videoTableView.dataSource = self;
        
        //添加头部和脚部刷新
//        [self addRefreshWithTableView:_videoTableView];
        
        self.videoTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            self.updataCount = 0;
            [self reloadVideoData];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.videoTableView reloadData];
            });
        }];
        self.videoTableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
            [self updateVideoData];
        }];
        
    }
    return _videoTableView;
}

- (void)reloadVideoData {
    [MWDataTool getVideoDataAndCallback:^(id obj) {
        self.videoArray = obj;
        
    }];
//    [_videoTableView reloadData];
    [_videoTableView.mj_header endRefreshing];
}

- (void)updateVideoData {
    self.updataCount += 1;
    NSMutableArray *addImageData = [NSMutableArray array];
    [addImageData addObjectsFromArray:self.videoArray];
    NSString *url = [NSString stringWithFormat:@"http://api.app.yiche.com/webapi/api.ashx?method=bit.videolist&catid=6&pageindex=%ld", self.updataCount + 1];
    __block NSArray *updateArray = [NSArray array];
    [MWDataTool getVideoDataAndCallback:^(id obj) {
        updateArray = obj;
        [addImageData addObjectsFromArray:updateArray];
        self.videoArray = [addImageData copy];
    } withURL:url];
    [_videoTableView.mj_footer endRefreshing];
    [_videoTableView reloadData];
}

//
//-(void)addRefreshWithTableView:(UITableView *)tableView
//{
//    __weak UITableView *weakTableView = tableView;
//    __weak typeof(self)weakSelf = self;
//    [tableView addHeaderRefresh:^{
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//            [weakSelf reloadVideoData];
////            [weakTableView reloadData];
//            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
//                [weakTableView endHeaderRefresh];
//            }];
//        });
//    }];
//    
//    [tableView addFooterRefresh:^{
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//            [weakSelf updateVideoData];
////            [weakTableView reloadData];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [weakTableView endFooterRefresh];
//            });
//        });
//    }];
//
//}

-(UIButton *)videoButton
{
    if (!_videoButton) {
        _videoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_videoButton setTitle:@"视频" forState:UIControlStateNormal];
        [_videoButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_videoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        _videoButton.titleLabel.font = [UIFont fontWithName:@"Noteworthy-Bold" size:21];
        
        [_videoButton setBackgroundImage:[UIImage imageNamed:@"buttonBackground"] forState:UIControlStateNormal];
        [_videoButton setBackgroundImage:[UIImage imageNamed:@"移动框"] forState:UIControlStateSelected];
        
        [_videoButton addTarget:self action:@selector(clickVideoButton) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:_videoButton];
        
        [_videoButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(64);
            make.left.mas_equalTo(self.view);
            make.right.mas_equalTo(self.judgeButton.mas_left);
            make.width.mas_equalTo(self.judgeButton);
            make.height.mas_equalTo(44);
        }];
    }
    return _videoButton;
}
-(void)clickVideoButton
{
    CGPoint point = self.tableView.frame.origin;
    self.scrollView.contentOffset = point;
    
    self.videoButton.selected = YES;
    self.judgeButton.selected = NO;
    
    
}


#pragma mark - -- judge

-(UITableView *)judgeTableView
{
    if (!_judgeTableView) {
        _judgeTableView = [[UITableView alloc]init];
        _judgeTableView.delegate = self;
        _judgeTableView.dataSource = self;
        [_judgeTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"judgeCell"];
        
        //[self.scrollView addSubview:_judgeTableView];
        
//        [_judgeTableView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(64+44);
//            make.left.right.bottom.mas_equalTo(self.view);
//        }];
        
//        [self addRefreshWithTableView:_judgeTableView];
        
        self.judgeTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self reloadJudgeData];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.judgeTableView reloadData];
            });
        }];
        self.judgeTableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
            [self updateJudgeData];
        }];
        
        [self addSwipeGestureToView:_judgeTableView withDirection:UISwipeGestureRecognizerDirectionRight];
    }
    return _judgeTableView;
}

- (void)reloadJudgeData {
    [MWDataTool getJudgeDataAndCallback:^(id obj) {
        self.judgeArray = obj;
        self.updataCount = 0;
    }];
    [self.judgeTableView.mj_header endRefreshing];
//    [self.judgeTableView reloadData];
}

- (void)updateJudgeData {
    self.updataCount += 1;
    NSMutableArray *addData = [NSMutableArray array];
    [addData addObjectsFromArray:self.judgeArray];
    NSString *url = [NSString stringWithFormat:@"http://api.ycapp.yiche.com/news/getnewslist?serialid=&pageindex=1&pagesize=20&categoryid=%ld", self.updataCount + 1];
    __block NSArray *updateArray = [NSArray array];
    [MWDataTool getJudgeDataAndCallback:^(id obj) {
        updateArray = obj;
        [addData addObjectsFromArray:updateArray];
        self.judgeArray = [addData copy];
    } withURL:url];
    [self.judgeTableView.mj_footer endRefreshing];
    [self.judgeTableView reloadData];
}

-(UIButton *)judgeButton
{
    if (!_judgeButton) {
        _judgeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_judgeButton setTitle:@"评测" forState:UIControlStateNormal];
        _judgeButton.titleLabel.font = [UIFont fontWithName:@"Noteworthy-Bold" size:21];
        [_judgeButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_judgeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_judgeButton setBackgroundImage:[UIImage imageNamed:@"buttonBackground"] forState:UIControlStateNormal];
        [_judgeButton setBackgroundImage:[UIImage imageNamed:@"移动框"] forState:UIControlStateSelected];
        
        [_judgeButton addTarget:self action:@selector(clickJudgeButton) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_judgeButton];
        
        [_judgeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.view);
            make.top.mas_equalTo(64);
            make.size.mas_equalTo(self.videoButton);
            make.left.mas_equalTo(self.videoButton.mas_right);
        }];
    }
    return _judgeButton;
}
-(void)clickJudgeButton
{
    CGPoint point = self.judgeTableView.frame.origin;
    self.scrollView.contentOffset = point;
    
    self.judgeButton.selected = YES;
    self.videoButton.selected = NO;
    
}


#pragma mark - -- TableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _videoTableView) {
        return self.videoArray.count;
    }
    
    return self.judgeArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _videoTableView) {
        MWVideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        MWVideo *video = self.videoArray[indexPath.row];
        cell.videoTitleLabel.text = video.videoTitle;
        cell.videoDurationLabel.text = video.videoDuration;
        cell.videoSummaryLabel.text = video.videoSummary;
        cell.videoDateLabel.text = video.videoCreatedTime;
        [cell.videoImageView sd_setImageWithURL:video.videoImage placeholderImage:[UIImage imageNamed:@"Poppies"]];
        return cell;
    }else{
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"judgeCell"];
        MWJudge *judge = self.judgeArray[indexPath.row];
        cell.textLabel.text = judge.judgeTitle;
        cell.detailTextLabel.text = judge.judgeDate;
        return cell;
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MWDetailViewController *detailViewController = [MWDetailViewController new];
    if (tableView == self.tableView) {
        MWVideo *video = self.videoArray[indexPath.row];
        detailViewController.url = video.videoMp4;
    }else{
        MWJudge *judge = self.judgeArray[indexPath.row];
        detailViewController.url = judge.judgeURL;
        
    }
    
    [self.navigationController pushViewController:detailViewController animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _videoTableView) {
        return 100;
    }
    return 44;
}




#pragma mark - 
-(UIScrollView *)scrollView
{
    if (!_scrollView) {
        
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.backgroundColor = [UIColor lightGrayColor];
        _scrollView.frame = CGRectMake(0, 64+44 ,self.view.bounds.size.width , self.view.bounds.size.height-64-44-44);;
        _scrollView.delegate = self;
        _scrollView.contentSize = CGSizeMake(self.view.bounds.size.width*2, self.view.bounds.size.height-64-44-44);
        
        _scrollView.scrollEnabled = YES;
        _scrollView.pagingEnabled = YES;
        _scrollView.directionalLockEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.bounces = YES;
        
        CGRect rect = CGRectMake(0, 0, _scrollView.bounds.size.width, _scrollView.bounds.size.height);
        rect.origin = CGPointZero;
        self.tableView.frame = rect;
        [_scrollView addSubview:self.tableView];
        
        rect.origin = CGPointMake(self.view.bounds.size.width, 0);
        self.judgeTableView.frame = rect;
        [_scrollView addSubview:self.judgeTableView];
        
        self.tableView.hidden = NO;
        self.judgeTableView.hidden = NO;
        
        [self.view addSubview:_scrollView];
        
    }
    return _scrollView;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //NSLog(@"scrollView = %@",scrollView);
    //NSLog(@"滚动视图滚动");
    if ([scrollView isMemberOfClass:[UIScrollView class]]) {
        int index = round( scrollView.contentOffset.x/scrollView.bounds.size.width);
        if (index == 1) {
            self.judgeButton.selected = YES;
            self.videoButton.selected = NO;
        }else{
            self.videoButton.selected = YES;
            self.judgeButton.selected = NO;
        }
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView.hidden = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.videoButton.hidden=NO;
    self.judgeButton.hidden=NO;
    self.videoButton.selected = YES;
    

    [MWDataTool getVideoDataAndCallback:^(id obj) {        
        self.videoArray = obj;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
    [MWDataTool getJudgeDataAndCallback:^(id obj) {
        self.judgeArray = obj;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.judgeTableView reloadData];
        });
    }];

    [self.view layoutIfNeeded];
   
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
















