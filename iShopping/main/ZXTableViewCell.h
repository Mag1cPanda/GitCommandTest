//
//  ZXTableViewCell.h
//  iShopping
//
//  Created by Siren on 15/10/13.
//  Copyright © 2015年 Siren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellRowsModel.h"
@interface ZXTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *rzlxLab;
@property (weak, nonatomic) IBOutlet UILabel *dateLab;
@property (weak, nonatomic) IBOutlet UIImageView *picture;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UILabel *comment;


-(void)setUIWithInfo:(CellRowsModel *)model;
@end
