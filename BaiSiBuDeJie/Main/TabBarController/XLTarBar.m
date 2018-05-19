//
//  XLTarBar.m
//  NormalProject
//
//  Created by 曹学亮 on 2018/5/14.
//  Copyright © 2018年 Cao Xueliang. All rights reserved.
//

#import "XLTarBar.h"
#import "PostsPublishView.h"

@interface XLTarBar()
@property (nonatomic,strong) UIButton *plusButton;
@property (nonatomic,strong) PostsPublishView *publishView;
@end

//tarBarIterm的个数
static const CGFloat XLTarBarItermCount = 5.0;
@implementation XLTarBar
#pragma mark - Init Menthod
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.plusButton];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    //设置加号按钮的位置
    CGFloat totalWidth = CGRectGetWidth(self.bounds);
    CGFloat totalHeight = CGRectGetHeight(self.bounds);
    self.plusButton.center = CGPointMake(totalWidth/2.0, totalHeight/2.0);
    
    //设置其它UITabBarButton的位置和尺寸
    NSMutableArray *barButtonArray = [[NSMutableArray alloc]init];
    CGFloat tabbarButtonW = self.frame.size.width / XLTarBarItermCount;
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        Class class = NSClassFromString(@"UITabBarButton");
        if ([obj isKindOfClass:class]) {
            [barButtonArray addObject:obj];
        }
    }];
    
    
    [barButtonArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *childView = obj;
        NSInteger currentIndex = idx > 1 ? idx + 1 : idx;
        childView.frame = CGRectMake(currentIndex * tabbarButtonW, CGRectGetMinY(childView.frame), tabbarButtonW, CGRectGetHeight(childView.frame));
        
    }];
    self.plusButton.frame = CGRectMake(2*tabbarButtonW,1, tabbarButtonW, 49 - 1);
    [self bringSubviewToFront:self.plusButton];
}

- (void)plusButtonClicked{
    _publishView = [[PostsPublishView alloc]initWithDoneBlock:^(NSString *itermString) {
        NSLog(@"%@",itermString);
    }];
    [_publishView showPickerView];
}

#pragma mark - Setter && Getter
- (UIButton *)plusButton{
    if (!_plusButton) {
        _plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_plusButton setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [_plusButton addTarget:self action:@selector(plusButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _plusButton;
}



@end
