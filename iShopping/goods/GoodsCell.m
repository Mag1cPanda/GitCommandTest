//
//  GoodsCell.m
//  iShopping
//
//  Created by Siren on 15/10/9.
//  Copyright © 2015年 Siren. All rights reserved.
//

#import "GoodsCell.h"

@implementation GoodsCell

-(void)setUIWithInfo:(WikiRowsModel *)model
{
    [self.imageV setImageWithURL:[NSURL URLWithString:model.article_pic]];
    self.imageV.contentMode = UIViewContentModeScaleAspectFit;
//    self.imageV.image.size
    
    self.priceLab.text = [NSString stringWithFormat:@"%@ 元起",model.article_price];
    self.titleLab.text = model.article_title;
    self.referrer.text = model.article_recommend_uname;
    self.reason.text = model.pro_subtitle;
    [self.reason sizeToFit];
    self.recommend.text = [NSString stringWithFormat:@"%@ 人认为值得买",model.article_recommend_count];
    
    self.collect.text = [NSString stringWithFormat:@"%@ 收藏",model.article_collect_count];
    
    self.comment.text = [NSString stringWithFormat:@"%@ 短评",model.article_comment_count];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
