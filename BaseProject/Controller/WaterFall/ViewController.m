//
//  ViewController.m
//  Demo4_Custom_Layout
//
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "ViewController.h"
#import "CustomLayout.h"
#import "Cell.h"
#import "MWDataTool.h"
#import "MWTabBarViewController.h"
#import <UIImageView+WebCache.h>
#import <MJRefresh.h>
#import "MWCLLCollectionViewController.h"

#import "MWImageViewController.h"

@interface ViewController () <UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic, assign)NSInteger *updateCount;

@end

@implementation ViewController

-(void)viewWillAppear:(BOOL)animated
{
    
}
static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor blackColor];
    self.collectionView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
   
    [self.collectionView registerClass:[Cell class] forCellWithReuseIdentifier:reuseIdentifier];
    self.navigationItem.title=@"靓车壁纸";
    // 加载数据
    [self loadImageData];
    
    //添加头部刷新，底部加载
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadImageData];
        self.updateCount = 0;
        
    }];
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self updateCollectionViewData];
    }];
    
    [self addNavigationItem];
}

- (void)loadImageData {
    [MWDataTool getImageDataAndCallback:^(id obj) {
        
        self.coursesArray = obj;
        [self.collectionView reloadData];
        CustomLayout *customLayout = (CustomLayout*)self.collectionViewLayout;
        customLayout.viewController = self;
        
    }];
    [self.collectionView.mj_header endRefreshing];
    [self.collectionView reloadData];
}

- (void)updateCollectionViewData {
    self.updateCount += 1;
    NSMutableArray *addData = [NSMutableArray array];
    [addData addObjectsFromArray:self.coursesArray];
    NSString *url = [NSString stringWithFormat:@"http://api.lovebizhi.com/android_v3.php?a=category&spdy=1&tid=798&order=hot&color_id=3&device=nubia%28NX507J%29&uuid=fcbee865a8102969f325d07cebf2ba4c&mode=1&client_id=1001&device_id=51209718&model_id=102&size_id=0&channel_id=70&screen_width=1080&screen_height=1920&bizhi_width=2160&bizhi_height=1920&version_code=73&language=zh-CN&mac=&original=0&p=%ld", self.updateCount + 1];
    __block NSArray *updateArray = [NSArray array];
    [MWDataTool getImageDataAndCallback:^(id obj) {
        updateArray = obj;
        [addData addObjectsFromArray:updateArray];
        self.coursesArray = [addData copy];
    } withUrl:url];
    [self.collectionView.mj_footer endRefreshing];
    [self.collectionView reloadData];
}


-(void)addNavigationItem
{
    UIBarButtonItem *imagesItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(imageShow)];
    self.navigationItem.rightBarButtonItem = imagesItem;
}
-(void)imageShow
{
//    UIImagePickerController *pickerController = [[UIImagePickerController alloc]init];
//    pickerController.delegate = self;
    
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];
    NSString *imagesPath = [cachePath stringByAppendingPathComponent:@"images"];

    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *fileList = [[NSArray alloc] initWithArray:[fileManager contentsOfDirectoryAtPath:imagesPath error:nil]];
    NSMutableArray *imageArray = [NSMutableArray array];
    for (int i = 0; i < fileList.count; i++) {
        
        if ([fileList[i] isEqualToString:@".DS_Store"]) {
            
        } else {
            NSString *imagePath = [imagesPath stringByAppendingPathComponent:fileList[i]];
            NSData *imageData = [NSData dataWithContentsOfFile:imagePath];
            UIImage *image = [UIImage imageWithData:imageData];
            [imageArray addObject:image];
        }
    }
    
    NSLog(@"filelist:%@", fileList);
    

    MYLog(@"cachePath: %@",imagesPath);
    MYLog(@"contents:%@",imageArray);
    MWCLLCollectionViewController *collViewController = [[MWCLLCollectionViewController alloc] initWithNibName:@"MWCLLCollectionViewController" bundle:nil];
    collViewController.imagesArray = imageArray;
    
//    pickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
//    pickerController.mediaTypes = imageArray;
    [self.navigationController pushViewController:collViewController animated:YES];
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSLog(@"count = %ld",self.coursesArray.count);
    return self.coursesArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    Cell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    MWImage *image = self.coursesArray[indexPath.row];
    UIImageView *imageView = [[UIImageView alloc] init];
    
    [imageView sd_setImageWithURL:image.imageShow placeholderImage:[UIImage imageNamed:@"缓冲.png"]];
    cell.backgroundView = imageView;
    imageView.frame = cell.bounds;
    imageView.backgroundColor = [UIColor blackColor];
    cell.backgroundView.contentMode  = UIViewContentModeScaleAspectFit;
    
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MWImage *image = self.coursesArray[indexPath.row];
    MWImageViewController *imageViewController = [[MWImageViewController alloc]initWithNibName:@"MWImageViewController" bundle:nil];
    imageViewController.imageUrl = image.imageShow;
    
    [self.navigationController pushViewController:imageViewController animated:YES];
}
/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
