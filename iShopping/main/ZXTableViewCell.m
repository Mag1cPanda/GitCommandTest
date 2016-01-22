//
//  ZXTableViewCell.m
//  iShopping
//
//  Created by Siren on 15/10/13.
//  Copyright © 2015年 Siren. All rights reserved.
//

#import "ZXTableViewCell.h"


@implementation ZXTableViewCell

-(void)setUIWithInfo:(CellRowsModel *)model{

    self.titleLab.text = model.article_title;
    self.rzlxLab.text = model.article_rzlx;
    self.dateLab.text = model.article_format_date;
    [self.picture setImageWithURL:[NSURL URLWithString:model.article_pic]];
//    [self.picture sizeToFit];
//    [self.picture clipsToBounds];
    self.content.text = model.article_filter_content;
    self.comment.text = model.article_comment;
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
