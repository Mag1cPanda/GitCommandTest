//
//  SubscribeCell.h
//  iShopping
//
//  Created by Siren on 15/10/10.
//  Copyright © 2015年 Siren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubRowsModel.h"
@interface SubscribeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *detail;
@property (weak, nonatomic) IBOutlet UILabel *comment;


-(void)setUIWithInfo:(SubRowsModel *)rowsModel ;
@end
