//
//  SubscribeCell.m
//  iShopping
//
//  Created by Siren on 15/10/10.
//  Copyright © 2015年 Siren. All rights reserved.
//

#import "SubscribeCell.h"

@implementation SubscribeCell

-(void)setUIWithInfo:(SubRowsModel *)rowsModel {
    [self.imageV setImageWithURL:[NSURL URLWithString:rowsModel.article_pic]];
    [self.imageV sizeToFit];
    self.label.text = [NSString stringWithFormat:@"订阅词：%@",rowsModel.dingyue_tags[0]];
    self.time.text = rowsModel.article_format_date;
    self.detail.text = rowsModel.article_title;
    self.comment.text = rowsModel.article_comment;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
