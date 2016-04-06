//
//  CollectionViewCell.m
//  WaterflowLayout
//
//  Created by 小蔡 on 16/4/6.
//  Copyright © 2016年 xiaocai. All rights reserved.
//

#import "CollectionViewCell.h"
#import "Shop.h"

@interface CollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end

@implementation CollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setShop:(Shop *)shop{
    _shop = shop;
}

@end
