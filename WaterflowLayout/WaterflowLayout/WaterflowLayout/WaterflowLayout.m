//
//  WaterflowLayout.m
//  WaterflowLayout
//
//  Created by 小蔡 on 16/4/6.
//  Copyright © 2016年 xiaocai. All rights reserved.
//

#import "WaterflowLayout.h"

@interface WaterflowLayout()
/** 这个字典用来存储每一列最大的Y值(每一列的高度) */
@property (nonatomic, strong) NSMutableDictionary *dict;

/** 存放所有的布局属性 */
@property (nonatomic, strong) NSMutableArray *attrsArray;

@end

@implementation WaterflowLayout

- (NSMutableDictionary *)dict{
    if (_dict == nil) {
        _dict = [NSMutableDictionary dictionary];
    }
    return _dict;
}

- (NSMutableArray *)attrsArray{
    if (_attrsArray == nil) {
        _attrsArray = [NSMutableArray array];
    }
    return _attrsArray;
}

//初始化操作
- (instancetype)init
{
    if (self = [super init]) {
        self.columnMargin = 10;
        self.rowMargin = 10;
        self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        self.columnsCount = 3;
    }
    return self;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

- (void)prepareLayout{
    //清空字典的y值
    for (int i =0 ; i<self.columnsCount; i++) {
        NSString *column = [NSString stringWithFormat:@"%d", i];
        self.dict[column] = @(self.sectionInset.top);
    }
    
    //添加数组
    [self.attrsArray removeAllObjects];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (int i =0 ; i<count; i++) {
        UICollectionViewLayoutAttributes *attr = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        [self.attrsArray addObject:attr];
    }
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //遍历字典找出最小y值所在的列
    __block NSString *minColumn = @"0";
    [self.dict enumerateKeysAndObjectsUsingBlock:^(NSString *column, NSNumber *maxY, BOOL * _Nonnull stop) {
        if ([self.dict[minColumn] floatValue] > [maxY floatValue]) {
            minColumn = column;
        }
    }];
    //计算尺寸
    CGFloat itemW = (self.collectionView.frame.size.width - self.sectionInset.left - self.sectionInset.right - (self.columnsCount -1)*self.columnMargin) / (self.columnsCount);
    
    CGFloat itemH = [self.delegate waterflowLayout:self heightWithWidth:itemW indexPath:indexPath];
    
    //计算位置
    CGFloat x = self.sectionInset.left + (itemW + self.columnMargin) * [minColumn intValue];
    CGFloat y = [self.dict[minColumn] floatValue] + self.rowMargin;
    
    // 更新这一列的最大Y值
    self.dict[minColumn] = @(y + itemH);
    
    
    UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    attr.frame = CGRectMake(x, y, itemW, itemH);
    
    return attr;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.attrsArray;
}

/**
 *  返回所有的尺寸
 */
- (CGSize)collectionViewContentSize
{
    __block NSString *maxColumn = @"0";
    [self.dict enumerateKeysAndObjectsUsingBlock:^(NSString *column, NSNumber *maxY, BOOL *stop) {
        if ([maxY floatValue] > [self.dict[maxColumn] floatValue]) {
            maxColumn = column;
        }
    }];
    return CGSizeMake(0, [self.dict[maxColumn] floatValue] + self.sectionInset.bottom);
}

@end
