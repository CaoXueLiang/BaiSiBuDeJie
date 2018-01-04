//
//  PostsCommentCell.h
//  BaiSiBuDeJie
//
//  Created by bjovov on 2018/1/3.
//  Copyright © 2018年 caoxueliang.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 帖子评论Cell
 */
@class PostsCommentModel;
@interface PostsCommentCell : UITableViewCell
@property (nonatomic,strong) PostsCommentModel *commentModel;
+ (CGFloat)cellHeightWithModel:(PostsCommentModel *)model;
@end
