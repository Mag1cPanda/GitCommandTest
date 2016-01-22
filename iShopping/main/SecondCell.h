//
//  SecondCell.h
//  iShopping
//
//  Created by Siren on 15/10/8.
//  Copyright © 2015年 Siren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubModel.h"

@class SecondCell;

@protocol SecondCellDelegate <NSObject>

-(void)bannerImageTap:(SecondCell *)cell;
-(void)topImageTap:(SecondCell *)cell;
-(void)bottemImageTap:(SecondCell *)cell;

@end

@interface SecondCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *bannerImg;
@property (weak, nonatomic) IBOutlet UIImageView *topImg;
@property (weak, nonatomic) IBOutlet UIImageView *bottemImg;

@property (copy, nonatomic) NSString *url;

@property (assign, nonatomic) id<SecondCellDelegate> delegate ;
@end
