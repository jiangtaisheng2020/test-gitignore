//
//  ViewController.m
//  CollectionViewDemo(照片墙)
//
//  Created by apple2015 on 16/8/11.
//  Copyright © 2016年 apple2015. All rights reserved.
//

#import "ViewController.h"
#import "TSImageViewCell.h"
#import "TSLineFlowLayout.h"
@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,strong)NSMutableArray * dataSource;
@property(nonatomic,strong)UICollectionView * collectionView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initData];
    [self.view addSubview:self.collectionView];
}


- (void)initData
{
    NSArray * array=@[@"http://img.xilexuan.com/download/app/20160426/t_2200245309_1342850_u1o2w2_449_600.jpg",@"http://img.xilexuan.com/download/app/20160426/t_2200245309_1342844_l3p5w9_337_600.jpg",@"http://img.xilexuan.com/download/app/20160426/t_2200245309_1342847_x6s0s8_449_600.jpg",@"http://img.xilexuan.com/download/app/20160426/t_2200245309_1342846_c6l8g1_449_600.jpg",@"http://img.xilexuan.com/download/app/20160426/t_2200245309_1342849_x3i3y1_337_600.jpg",@"http://img.xilexuan.com/download/app/20160426/t_2200245309_1342845_l8b7n9_449_600.jpg"];


    for (int  i=0; i<20; i++) {
        
        [self.dataSource addObject:[NSString stringWithFormat:@"%d",i+1]];
    }

    [self.dataSource addObjectsFromArray:array];
}

-(NSMutableArray *)dataSource
{
    
    if (_dataSource==nil) {
        
        _dataSource=[NSMutableArray array ];
        
    }
    return _dataSource;
    
    
}


-(UICollectionView*)collectionView
{
    
    if (_collectionView==nil) {
        _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 200) collectionViewLayout:[[TSLineFlowLayout alloc]init]];
        
        _collectionView.dataSource=self;
        _collectionView.delegate=self;
        
        [_collectionView registerNib:[UINib nibWithNibName:@"TSImageViewCell" bundle:nil] forCellWithReuseIdentifier:@"image"];
    }
    
    return _collectionView;
    
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    
    return self.dataSource.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TSImageViewCell * cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"image" forIndexPath:indexPath];
    
    cell.image=  self.dataSource[indexPath.row];
    
    return cell;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
