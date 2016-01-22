//
//  ThirdCell.m
//  iShopping
//
//  Created by Siren on 15/10/8.
//  Copyright © 2015年 Siren. All rights reserved.
//

#import "ThirdCell.h"
#import "CellRowsModel.h"
#import "UIImageView+AFNetworking.h"
@implementation ThirdCell

-(void)setUIWithInfo:(CellRowsModel *)model{
    
    
    
    [self.icon setImageWithURL:[NSURL URLWithString:model.article_pic]];
    if (model.article_mall == nil) {
        model.article_mall = model.article_channel_name;
    }
    self.label.text = model.article_mall;
    self.time.text = model.article_format_date;
    self.detail.text = model.article_title;
//    self.detail.numberOfLines = 2;
    self.priceLab.text = model.article_price;
    self.comments.text = model.article_comment;
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
