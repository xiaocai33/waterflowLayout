//
//  CollectionViewCell.m
//  WaterflowLayout
//
//  Created by 小蔡 on 16/4/6.
//  Copyright © 2016年 xiaocai. All rights reserved.
//

#import "CollectionViewCell.h"
#import "Shop.h"
#import "UIImageView+WebCache.h"
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
    // 1.图片
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:shop.img] placeholderImage:[UIImage imageNamed:@"loading"]];
    // 2.价格
    self.priceLabel.text = shop.price;
}

@end
