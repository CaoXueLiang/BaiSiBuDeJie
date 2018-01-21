//
//  CXLMineCollectionViewCell.m
//  BaiSiBuDeJie
//
//  Created by 曹学亮 on 2018/1/21.
//  Copyright © 2018年 caoxueliang.cn. All rights reserved.
//

#import "CXLMineCollectionViewCell.h"
#import "CXLMineItermModel.h"
#import "UIButton+Aliment.h"

@interface CXLMineCollectionViewCell()
@property (nonatomic,strong) UIButton *itermButton;
@end

@implementation CXLMineCollectionViewCell
#pragma mark - Init Menthod
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubViews];
    }
    return self;
}

- (void)addSubViews{
    _itermButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_itermButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _itermButton.userInteractionEnabled = NO;
    _itermButton.titleLabel.font = [UIFont systemFontOfSize:12.5];
    [self.contentView addSubview:_itermButton];
    [_itermButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
    }];
}

- (void)setItermModel:(CXLMineItermModel *)itermModel{
    [_itermButton setTitle:itermModel.tip forState:UIControlStateNormal];
    [_itermButton setImage:[UIImage imageNamed:itermModel.imageName] forState:UIControlStateNormal];
    [_itermButton layoutImageTitleVerticalOffSet:5];
}

@end
