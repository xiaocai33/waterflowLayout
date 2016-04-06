//
//  WaterflowLayout.h
//  WaterflowLayout
//
//  Created by 小蔡 on 16/4/6.
//  Copyright © 2016年 xiaocai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WaterflowLayout;
@protocol WaterflowLayoutDelegate <NSObject>

- (CGFloat)waterflowLayout:(WaterflowLayout *)waterflowLayout heightWithWidth:(CGFloat)width indexPath:(NSIndexPath *)indexPath;

@end

@interface WaterflowLayout : UICollectionViewLayout

/** 设置内间距 */
@property (nonatomic, assign) UIEdgeInsets sectionInset;
/** 每一列之间的间距 */
@property (nonatomic, assign) CGFloat columnMargin;
/** 每一行之间的间距 */
@property (nonatomic, assign) CGFloat rowMargin;
/** 显示多少列 */
@property (nonatomic, assign) int columnsCount;

@property (nonatomic, weak) id<WaterflowLayoutDelegate> delegate;

@end
