//
//  PostsCommentSectionHeaderView.h
//  BaiSiBuDeJie
//
//  Created by bjovov on 2018/1/16.
//  Copyright © 2018年 caoxueliang.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 帖子详情评论sectionHeader
 */
@interface PostsCommentSectionHeaderView : UITableViewHeaderFooterView
- (void)setSectionTitle:(NSString *)sectionTitle;
+ (CGFloat)sectionHeight;
@end
