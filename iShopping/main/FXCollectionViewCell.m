//
//  FXCollectionViewCell.m
//  iShopping
//
//  Created by Siren on 15/10/12.
//  Copyright © 2015年 Siren. All rights reserved.
//

#import "FXCollectionViewCell.h"

@implementation FXCollectionViewCell

-(void)setUIWithInfo:(CellRowsModel *)model{
    
    [self.fxImage setImageWithURL:[NSURL URLWithString:model.article_pic]];
    self.mallLab.text = model.article_mall;
    self.timeLab.text = model.article_format_date;
    self.titleLab.text = model.article_title;
    self.comment.text = model.article_comment;
    self.priceLab.text = model.article_price;
    

}
- (void)awakeFromNib {
    // Initialization code
}

@end
