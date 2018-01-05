//
//  PostsDetailController.h
//  BaiSiBuDeJie
//
//  Created by bjovov on 2018/1/5.
//  Copyright © 2018年 caoxueliang.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 帖子详情
 */
@class PostsModel;
@interface PostsDetailController : UIViewController
+ (instancetype)initWithPostsModel:(PostsModel *)model;
@end
