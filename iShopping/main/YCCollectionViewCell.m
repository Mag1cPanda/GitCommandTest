//
//  YCCollectionViewCell.m
//  iShopping
//
//  Created by Siren on 15/10/13.
//  Copyright © 2015年 Siren. All rights reserved.
//

#import "YCCollectionViewCell.h"

@implementation YCCollectionViewCell

-(void)setUIWithInfo:(CellRowsModel *)model{
    
    self.typeLab.layer.cornerRadius = 5;
    self.typeLab.clipsToBounds = YES;
    self.typeLab.text = model.article_type_name;
    [self.ycImage setImageWithURL:[NSURL URLWithString:model.article_pic]];
    self.comment.text = model.article_comment;
    self.title.text = model.article_title;
}
- (void)awakeFromNib {
    // Initialization code
}

@end
