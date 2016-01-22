//
//  YCCollectionViewCell.h
//  iShopping
//
//  Created by Siren on 15/10/13.
//  Copyright © 2015年 Siren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellRowsModel.h"
@interface YCCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *typeLab;
@property (weak, nonatomic) IBOutlet UIImageView *ycImage;
@property (weak, nonatomic) IBOutlet UILabel *comment;
@property (weak, nonatomic) IBOutlet UILabel *title;


-(void)setUIWithInfo:(CellRowsModel *)model;
@end
