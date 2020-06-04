//
//  NPRefreshHeader.m
//  MJRefreshExample
//
//  Created by 李永杰 on 2020/5/22.
//  Copyright © 2020 NewPath. All rights reserved.
//

#import "NPRefreshHeader.h"
#import "UIImageView+NPGIF.h"

@interface NPRefreshHeader()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UIImageView *gifImageView;

@end

@implementation NPRefreshHeader

- (void)prepare
{
    [super prepare];
    
    // 设置控件的高度
    self.mj_h = 90;
    
    [self configUI];
}

- (void)configUI {
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textColor = [UIColor colorWithRed:1.0 green:0.5 blue:0.0 alpha:1.0];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.text = @"开启上岸之路";
    [self addSubview:self.titleLabel];
    
    self.tipLabel = [[UILabel alloc] init];
    self.tipLabel.textColor = [UIColor colorWithRed:1.0 green:0.5 blue:0.0 alpha:1.0];
    self.tipLabel.font = [UIFont boldSystemFontOfSize:16];
    self.tipLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:self.tipLabel];
    
    self.gifImageView = [[UIImageView alloc] init];
    [self.gifImageView npgif_setImage:[[NSURL alloc]initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"pull_down" ofType:@"gif"]]];
    [self addSubview:self.gifImageView];
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];
    
    self.gifImageView.frame = CGRectMake((self.mj_w-83)/2.0-50, (self.mj_h - 147/2.0)/2.0, 83/2.0, 147/2.0);
    self.titleLabel.frame = CGRectMake(self.gifImageView.mj_origin.x + self.gifImageView.mj_w + 20, 20, 200, 30);
    self.tipLabel.frame = CGRectMake(self.gifImageView.mj_origin.x + self.gifImageView.mj_w + 20, 60, 200, 30);
}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
    
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    
    switch (state) {
        case MJRefreshStateIdle:
            self.tipLabel.text = @"下拉刷新...";
            break;
        case MJRefreshStatePulling:
            self.tipLabel.text = @"松手刷新...";
            break;
        case MJRefreshStateRefreshing:
            self.tipLabel.text = @"加载数据中...";
            break;
        default:
            break;
    }
}

#pragma mark 监听拖拽比例（控件被拖出来的比例）
- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
    
    // 1.0 0.5 0.0
    // 0.5 0.0 0.5
    CGFloat red = 1.0 - pullingPercent * 0.5;
    CGFloat green = 0.5 - 0.5 * pullingPercent;
    CGFloat blue = 0.5 * pullingPercent;
    self.titleLabel.textColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

@end
