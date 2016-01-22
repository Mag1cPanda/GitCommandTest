//
//  SegmentControl.h
//  Testi
//
//  Created by Siren on 15/10/11.
//  Copyright © 2015年 Siren. All rights reserved.
//

/**
 *  左右切换的pageControl
 *
 *  效果为X易的效果
 */

#import <UIKit/UIKit.h>

typedef void(^XTSegmentControlBlock)(NSInteger index);

@class XTSegmentControl;

@protocol XTSegmentControlDelegate <NSObject>

- (void)segmentControl:(XTSegmentControl *)control selectedIndex:(NSInteger)index;

@end

@interface XTSegmentControl : UIView

- (instancetype)initWithFrame:(CGRect)frame Items:(NSArray *)titleItem delegate:(id <XTSegmentControlDelegate>)delegate;

- (instancetype)initWithFrame:(CGRect)frame Items:(NSArray *)titleItem selectedBlock:(XTSegmentControlBlock)selectedHandle;

- (void)selectIndex:(NSInteger)index;

- (void)moveIndexWithProgress:(float)progress;

- (void)endMoveIndex:(NSInteger)index;

@end
