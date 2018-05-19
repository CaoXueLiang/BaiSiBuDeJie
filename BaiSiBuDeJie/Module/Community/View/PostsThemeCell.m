//
//  PostsThemeCell.m
//  BaiSiBuDeJie
//
//  Created by 曹学亮 on 2018/1/21.
//  Copyright © 2018年 caoxueliang.cn. All rights reserved.
//

#import "PostsThemeCell.h"
#import "PostsCommunityModel.h"

@interface PostsThemeCell()
@property (nonatomic,strong) UIImageView *themeImageView;
@property (nonatomic,strong) UILabel *themeLabel;
@property (nonatomic,strong) UILabel *updateLabel;
@property (nonatomic,strong) UIView *selectedView;
@end

@implementation PostsThemeCell
#pragma mark - Init Menthod
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubViews];
        self.selectedBackgroundView = self.selectedView;
        self.dk_backgroundColorPicker = DKColorPickerWithKey(CellBG);
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

- (void)addSubViews{
    [self.contentView addSubview:self.themeImageView];
    [self.themeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(12);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    [self.contentView addSubview:self.themeLabel];
    [self.themeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.themeImageView.mas_right).offset(10);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:self.updateLabel];
    [self.updateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView);
        make.centerY.equalTo(self.contentView);
    }];
}

#pragma mark - Public Menthod
- (void)setModel:(PostsCommunityModel *)model{
    [_themeImageView sd_setImageWithURL:[NSURL URLWithString:model.image_list]];
    _themeLabel.text = model.theme_name;
    _updateLabel.text = [NSString stringWithFormat:@"%@条更新",model.today_topic_num];
}

+ (CGFloat)cellHeight{
    return 66.0f;
}

#pragma mark - Setter && Getter
- (UIImageView *)themeImageView{
    if (!_themeImageView) {
        _themeImageView = [[UIImageView alloc]init];
        _themeImageView.layer.cornerRadius = 5;
        _themeImageView.layer.masksToBounds = YES;
    }
    return _themeImageView;
}

- (UILabel *)themeLabel{
    if (!_themeLabel) {
        _themeLabel = [UILabel new];
        _themeLabel.font = [UIFont systemFontOfSize:15];
        _themeLabel.textColor = [UIColor blackColor];
        _themeLabel.dk_textColorPicker = DKColorPickerWithKey(DetailLabelColor);
    }
    return _themeLabel;
}

- (UILabel *)updateLabel{
    if (!_updateLabel) {
        _updateLabel = [UILabel new];
        _updateLabel.font = [UIFont systemFontOfSize:12];
        _updateLabel.textColor = [UIColor lightGrayColor];
        _themeLabel.dk_textColorPicker = DKColorPickerWithKey(LabelColor);
    }
    return _updateLabel;
}

- (UIView *)selectedView{
    if (!_selectedView) {
        _selectedView = [UIView new];
        _selectedView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _selectedView;
}

@end
