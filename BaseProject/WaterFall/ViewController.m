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
@interface ViewController ()


@end

@implementation ViewController

- (instancetype)init {
    if (self = [super init]) {
        self.title = @"第三个";
        self.tabBarItem.image = [UIImage imageNamed:@"video"];
    }
    return self;
}


static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor blackColor];
    self.collectionView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
   
    [self.collectionView registerClass:[Cell class] forCellWithReuseIdentifier:reuseIdentifier];
    self.navigationItem.title=@"靓车壁纸";

    
    [MWDataTool getImageDataAndCallback:^(id obj) {

        self.coursesArray = obj;
        [self.collectionView reloadData];
        CustomLayout *customLayout = (CustomLayout*)self.collectionViewLayout;
        customLayout.viewController = self;
        
        
        
    }];

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
    cell.backgroundView = imageView;
    [imageView sd_setImageWithURL:image.imageShow placeholderImage:[UIImage imageNamed:@"缓冲.png"]];
    imageView.frame = cell.bounds;
    imageView.backgroundColor = [UIColor blackColor];
    cell.backgroundView.contentMode  = UIViewContentModeScaleAspectFit;
    
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

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
