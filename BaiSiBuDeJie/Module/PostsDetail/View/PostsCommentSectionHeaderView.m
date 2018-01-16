//
//  PostsCommentSectionHeaderView.m
//  BaiSiBuDeJie
//
//  Created by bjovov on 2018/1/16.
//  Copyright © 2018年 caoxueliang.cn. All rights reserved.
//

#import "PostsCommentSectionHeaderView.h"

@interface PostsCommentSectionHeaderView()
@property (nonatomic,strong) UILabel *tipLabel;
@end

@implementation PostsCommentSectionHeaderView
#pragma mark - Init Menthod
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubViews];
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)addSubViews{
    _tipLabel = [UILabel new];
    _tipLabel.textColor = RGBColor(60, 60, 60, 1);
    _tipLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_tipLabel];
    [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(kWBCellPaddingText);
        make.right.equalTo(self.contentView).offset(-kWBCellPaddingText);
        make.centerY.equalTo(self.contentView);
        make.height.mas_equalTo(20);
    }];
}

- (void)setSectionTitle:(NSString *)sectionTitle{
    _tipLabel.text = sectionTitle ? : @"";
}

+ (CGFloat)sectionHeight{
    return 45.0f;
}

@end
