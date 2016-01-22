//
//  FXCollectionViewCell.h
//  iShopping
//
//  Created by Siren on 15/10/12.
//  Copyright © 2015年 Siren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellRowsModel.h"
@interface FXCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *fxImage;
@property (weak, nonatomic) IBOutlet UILabel *mallLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@property (weak, nonatomic) IBOutlet UILabel *comment;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;

-(void)setUIWithInfo:(CellRowsModel *)model;
@end
