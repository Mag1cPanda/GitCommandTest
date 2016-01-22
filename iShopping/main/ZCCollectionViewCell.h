//
//  ZCCollectionViewCell.h
//  iShopping
//
//  Created by Siren on 15/10/13.
//  Copyright © 2015年 Siren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellRowsModel.h"
@interface ZCCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *status;
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *needLab;
@property (weak, nonatomic) IBOutlet UILabel *goldOrPoint;
@property (weak, nonatomic) IBOutlet UILabel *numLab;

-(void)setUIWithInfo:(CellRowsModel *)model;
@end
