//
//  CXLMineLoginCell.m
//  BaiSiBuDeJie
//
//  Created by 曹学亮 on 2018/1/21.
//  Copyright © 2018年 caoxueliang.cn. All rights reserved.
//

#import "CXLMineLoginCell.h"

@interface CXLMineLoginCell()
@property (nonatomic,strong) UIImageView *avatarImageView;
@property (nonatomic,strong) UILabel *nickNameLabel;
@property (nonatomic,strong) UIView *selectView;
@end

@implementation CXLMineLoginCell
#pragma mark - Init Menthod
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubViews];
        self.selectedBackgroundView = self.selectView;
    }
    return self;
}

- (void)addSubViews{
    [self.contentView addSubview:self.avatarImageView];
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(12);
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:self.nickNameLabel];
    [self.nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarImageView.mas_right).offset(12);
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-12);
    }];
}

+ (CGFloat)cellHeight{
    return 75.0f;
}

#pragma mark - Setter && Getter
- (UIImageView *)avatarImageView{
    if (!_avatarImageView) {
        _avatarImageView = [[UIImageView alloc]init];
        _avatarImageView.layer.cornerRadius = 40/2.0;
        _avatarImageView.layer.masksToBounds = YES;
        _avatarImageView.image = [UIImage imageNamed:@"headerPlaceholder"];
    }
    return _avatarImageView;
}

- (UILabel *)nickNameLabel{
    if (!_nickNameLabel) {
        _nickNameLabel = [UILabel new];
        _nickNameLabel.textColor = [UIColor blackColor];
        _nickNameLabel.font = [UIFont systemFontOfSize:16];
        _nickNameLabel.text = @"登录/注册";
    }
    return _nickNameLabel;
}

- (UIView *)selectView{
    if (!_selectView) {
        _selectView = [UIView new];
        _selectView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _selectView;
}

@end
