//
//  TSLineFlowLayout.m
//  CollectionViewDemo(照片墙)
//
//  Created by apple2015 on 16/8/11.
//  Copyright © 2016年 apple2015. All rights reserved.
//

#import "TSLineFlowLayout.h"
@interface TSLineFlowLayout ()


@end

@implementation TSLineFlowLayout

static  float IMAGEW=100;
- (instancetype)init
{

    if (self=[super init]) {
        
    }

    return self;
}

/**
 *  一些初始化工作最好在这里实现
 */
- (void)prepareLayout
{
    NSLog(@"---------%s\n",__func__);
    [super prepareLayout];
    self.minimumLineSpacing=IMAGEW*0.5;
    self.itemSize=CGSizeMake(IMAGEW, IMAGEW);
    self.scrollDirection=UICollectionViewScrollDirectionHorizontal;

    CGFloat inset = (self.collectionView.frame.size.width - IMAGEW) * 0.5;
    self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset);
    
}
/**
 *  只要显示的边界发生改变就重新布局:
 内部会重新调用prepareLayout和layoutAttributesForElementsInRect方法获得所有cell的布局属性
 */
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    NSLog(@"---------%s\n",__func__);

    return YES;
}

/** 有效距离:当item的中间x距离屏幕的中间x在HMActiveDistance以内,才会开始放大, 其它情况都是缩小 */
static CGFloat const HMActiveDistance = 150;
/** 缩放因素: 值越大, item就会越大 */
static CGFloat const HMScaleFactor = 0.5;

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSLog(@"---------%s\n",__func__);

    CGRect visibleRect;
    visibleRect.size=self.collectionView.frame.size;
    visibleRect.origin=self.collectionView.contentOffset;
    
    NSArray * array=[super layoutAttributesForElementsInRect:visibleRect];
    
    CGFloat centerX=self.collectionView.contentOffset.x+ self.collectionView.frame.size.width * 0.5;
    
    
    for (UICollectionViewLayoutAttributes * attr in array) {
        
        if (!CGRectIntersectsRect(visibleRect, attr.frame)) continue;

        CGFloat  scale=1+(1-ABS((centerX-attr.center.x))/HMActiveDistance)*HMScaleFactor;
  
        attr.transform=CGAffineTransformMakeScale(scale, scale);
        
    }
  
    return array;
    
}


- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    NSLog(@"---------%s\n",__func__);


    //  重新设置proposedContentOffset，，目的是item 每次只滑到下一个item
    if (proposedContentOffset.x>_offSet) {

        proposedContentOffset.x=_offSet+150;

    }else{

        proposedContentOffset.x=_offSet-150;
    }

    // 1.计算出scrollView最后会停留的范围
    CGRect lastRect;
    lastRect.size=self.collectionView.frame.size;
    lastRect.origin=proposedContentOffset;
     // 2.取出这个范围内的所有属性
    NSArray * array=[self layoutAttributesForElementsInRect:lastRect];
    // 计算屏幕最中间的x

    CGFloat centerX=proposedContentOffset.x+ self.collectionView.frame.size.width * 0.5;
      // 3.遍历所有属性
    CGFloat   distance=MAXFLOAT;
    for (UICollectionViewLayoutAttributes * attr in array) {

        if (ABS( attr.center.x-centerX)<ABS(distance)) {
            distance=attr.center.x-centerX;
        }

    }
    _offSet=proposedContentOffset.x + distance;

    return CGPointMake(proposedContentOffset.x+distance, proposedContentOffset.y);

}
@end
