//
//  PostsCommentCell.m
//  BaiSiBuDeJie
//
//  Created by bjovov on 2018/1/3.
//  Copyright © 2018年 caoxueliang.cn. All rights reserved.
//

#import "PostsCommentCell.h"
#import <YYText/YYText.h>
#import "PostsModel.h"

@interface PostsCommentCell()
@property (nonatomic,strong) YYLabel *commentLabel; //文字评论Label
@end

@implementation PostsCommentCell
#pragma mark - Init Menthod
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _commentLabel = [YYLabel new];
        _commentLabel.origin = CGPointMake(kWBCellPaddingText, 5);
        _commentLabel.width = kScreenWidth - 2*kWBCellPadding - 2*kWBCellPaddingText;
        [self.contentView addSubview:_commentLabel];
        self.contentView.backgroundColor = kWBCellHighlightColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

#pragma mark - Public Menthod
- (void)setCommentModel:(PostsCommentModel *)commentModel{
    if (!commentModel) {
        return;
    }
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:CGSizeMake(kScreenWidth - 2*kWBCellPadding - 2*kWBCellPaddingText, CGFLOAT_MAX) text:[self stringWithModel:commentModel]];
    _commentLabel.textLayout = layout;
    _commentLabel.height = layout.textBoundingSize.height;
}

+ (CGFloat)cellHeightWithModel:(PostsCommentModel *)model{
    if (!model) {
        return 0;
    }
    CGSize size = CGSizeMake(kScreenWidth - 2*kWBCellPadding - 2*kWBCellPaddingText, CGFLOAT_MAX);
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:size text:[[PostsCommentCell new] stringWithModel:model]];
    return layout.textBoundingSize.height + 10;
}

- (NSMutableAttributedString *)stringWithModel:(PostsCommentModel *)model{
    NSMutableAttributedString *comment = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@: %@",model.u.name,model.content]];
    comment.yy_font = [UIFont systemFontOfSize:13.5];
    comment.yy_color = [UIColor blackColor];
    [comment yy_setColor:MainNameColor range:NSMakeRange(0, model.u.name.length)];
    comment.yy_lineSpacing = 5;
    return comment;
}

@end
