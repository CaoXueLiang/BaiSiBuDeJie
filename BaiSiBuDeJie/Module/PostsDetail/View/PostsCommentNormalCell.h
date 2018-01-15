//
//  PostsCommentNormalCell.h
//  BaiSiBuDeJie
//
//  Created by bjovov on 2018/1/15.
//  Copyright © 2018年 caoxueliang.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 帖子评论详情NormalCell
 */
@class PostsCommentDetailNormalLayout;
@interface PostsCommentNormalCell : UITableViewCell
- (void)setLayout:(PostsCommentDetailNormalLayout *)layout index:(NSInteger)index;
@end
