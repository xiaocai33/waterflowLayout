//
//  ViewController.m
//  WaterflowLayout
//
//  Created by 小蔡 on 16/4/6.
//  Copyright © 2016年 xiaocai. All rights reserved.
//

#import "ViewController.h"
#import "WaterflowLayout.h"
#import "CollectionViewCell.h"
#import "Shop.h"

static NSString * const ID = @"shop";

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) NSMutableArray *shops;

@end

@implementation ViewController

- (NSMutableArray *)shops{
    if (_shops == nil) {
        _shops = [NSMutableArray array];
    }
    return _shops;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WaterflowLayout *layout = [[WaterflowLayout alloc] init];
    
    UICollectionView *collection = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    
    collection.delegate = self;
    collection.dataSource = self;
    
    [collection registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:ID];
    
    [self.view addSubview:collection];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.shops.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    cell.shop = self.shops[indexPath.item];
    
    return cell;
}



@end
