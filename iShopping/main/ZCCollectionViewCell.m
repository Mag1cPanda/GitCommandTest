//
//  ZCCollectionViewCell.m
//  iShopping
//
//  Created by Siren on 15/10/13.
//  Copyright © 2015年 Siren. All rights reserved.
//

#import "ZCCollectionViewCell.h"

@implementation ZCCollectionViewCell


-(void)setUIWithInfo:(CellRowsModel *)model{
    
    self.status.layer.cornerRadius = 5;
    self.status.clipsToBounds = YES;
    self.status.text = model.probation_status_name;
    [self.img setImageWithURL:[NSURL URLWithString:model.probation_img]];
    self.title.text = model.probation_title;
    self.numLab.text = model.probation_product_num;
    if ([model.probation_need_point isEqualToString:@"0"]) {
        self.needLab.text = model.probation_need_gold;
        self.goldOrPoint.text = @"金币";
    }
    else if([model.probation_need_gold isEqualToString:@"0"]){
        
        self.needLab.text = model.probation_need_point;
        self.goldOrPoint.text = @"积分";
    }
}

- (void)awakeFromNib {
    // Initialization code
}

@end
