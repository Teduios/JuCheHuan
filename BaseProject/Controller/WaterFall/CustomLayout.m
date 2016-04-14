//
//  CustomLayout.m
//  Demo4_Custom_Layout
//
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "CustomLayout.h"
#import "ViewController.h"

static CGFloat lineSpacing = 10;
@implementation CustomLayout

//内容区域总大小，不是可见区域
- (CGSize)collectionViewContentSize {
    
    return  CGSizeMake(self.collectionView.bounds.size.width,(5*self.collectionView.bounds.size.width+6*lineSpacing)*self.viewController.coursesArray.count/27-(lineSpacing*self.viewController.coursesArray.count/3));

}

//所有单元格位置信息
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSMutableArray *array = [NSMutableArray array];
    CGFloat cellCount = [self.collectionView numberOfItemsInSection:0];
    for (NSInteger i = 0; i<cellCount; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attribute = [self layoutAttributesForItemAtIndexPath:indexPath];
        [array addObject:attribute];
    }
    return array;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    //大图的宽
    
    CGFloat largeCellWidthSider = (10*self.collectionView.bounds.size.width-24*lineSpacing)/15;
    
    //    大图的高
    CGFloat largeCellHeightSider = (5*self.collectionView.bounds.size.width-12*lineSpacing)/9;
    //小图的宽
    CGFloat smallCellWidthSider= (self.collectionView.bounds.size.width/3)-lineSpacing;
    //    小图的高
    CGFloat smallCellHeightSider = (5*self.collectionView.bounds.size.width/18)-(7*lineSpacing/6);
    
    //定义CELL距离view的边框
    
    UIEdgeInsets insets = UIEdgeInsetsMake(lineSpacing, lineSpacing, lineSpacing, lineSpacing);
    //整个cell一共有几条，因为一条有三个图片
    NSInteger line = indexPath.item / 3;
    
    //Y  图片的纵坐标
    CGFloat lineOriginY = largeCellHeightSider*(CGFloat)line+lineSpacing*line+insets.top;
    //x
    CGFloat rightLargeX = self.collectionView.bounds.size.width - largeCellWidthSider  - insets.right;
    CGFloat rightSmallX = self.collectionView.bounds.size.width - smallCellWidthSider - insets.right;
    
    if (indexPath.item % 6 ==0) {
        attribute.frame = CGRectMake(insets.left, lineOriginY, largeCellWidthSider, largeCellHeightSider);
    }else if(indexPath.item % 6 == 1){
        attribute.frame = CGRectMake(rightSmallX, lineOriginY, smallCellWidthSider, smallCellHeightSider);
    }else if(indexPath.item % 6 == 2){
        attribute.frame = CGRectMake(rightSmallX, lineOriginY+smallCellHeightSider+insets.top , smallCellWidthSider, smallCellHeightSider);
    }else if(indexPath.item % 6 == 4){
        attribute.frame = CGRectMake(insets.left, lineOriginY, smallCellWidthSider, smallCellHeightSider);
    }else if(indexPath.item % 6 == 5){
        attribute.frame = CGRectMake(insets.left, lineOriginY+smallCellHeightSider+insets.top, smallCellWidthSider, smallCellHeightSider);
    }else if(indexPath.item % 6 == 3){
        attribute.frame = CGRectMake(rightLargeX, lineOriginY, largeCellWidthSider, largeCellHeightSider);
    }
    
    return attribute;
}
@end
